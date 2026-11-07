import Foundation
import Capacitor
import GameKit

/// Box Smash leaderboard bridge.
/// submit: sends the player's best level, with their character packed into the score's context number.
/// load:   reads the top entries (everyone or friends) plus the local player's own entry.
@objc(BoxBoardPlugin)
public class BoxBoardPlugin: CAPPlugin {

    @objc func submit(_ call: CAPPluginCall) {
        guard GKLocalPlayer.local.isAuthenticated else { call.reject("Not signed in to Game Center"); return }
        if #available(iOS 14.0, *) {
            submitScore(call)
        } else {
            call.reject("Needs iOS 14 or newer")
        }
    }

    @objc func load(_ call: CAPPluginCall) {
        guard GKLocalPlayer.local.isAuthenticated else { call.reject("Not signed in to Game Center"); return }
        if #available(iOS 14.0, *) {
            loadEntries(call)
        } else {
            call.reject("Needs iOS 14 or newer")
        }
    }

    @available(iOS 14.0, *)
    private func submitScore(_ call: CAPPluginCall) {
        let id = call.getString("leaderboardID") ?? ""
        let score = call.getInt("score") ?? 0
        let context = call.getInt("context") ?? 0
        GKLeaderboard.submitScore(score, context: context, player: GKLocalPlayer.local, leaderboardIDs: [id]) { error in
            if let error = error { call.reject(error.localizedDescription) } else { call.resolve() }
        }
    }

    @available(iOS 14.0, *)
    private func loadEntries(_ call: CAPPluginCall) {
        let id = call.getString("leaderboardID") ?? ""
        let friends = call.getString("scope") == "friends"
        let count = max(1, min(100, call.getInt("count") ?? 50))
        GKLeaderboard.loadLeaderboards(IDs: [id]) { boards, error in
            guard let board = boards?.first else {
                call.reject(error?.localizedDescription ?? "Leaderboard not found")
                return
            }
            board.loadEntries(for: friends ? .friendsOnly : .global,
                              timeScope: .allTime,
                              range: NSRange(location: 1, length: count)) { local, entries, total, error in
                if let error = error { call.reject(error.localizedDescription); return }
                var result: [String: Any] = [
                    "entries": (entries ?? []).map { BoxBoardPlugin.pack($0) },
                    "total": total
                ]
                if let local = local { result["local"] = BoxBoardPlugin.pack(local) }
                call.resolve(result)
            }
        }
    }

    @available(iOS 14.0, *)
    private static func pack(_ e: GKLeaderboard.Entry) -> [String: Any] {
        return [
            "name": e.player.displayName,
            "rank": e.rank,
            "score": e.score,
            "context": e.context,
            "me": e.player.gamePlayerID == GKLocalPlayer.local.gamePlayerID
        ]
    }
}
