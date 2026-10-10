# Box Smash

3D cannon physics puzzle game. Single-file `index.html`.

- `index.html` – the game (works in a browser; the iOS build bundles its libraries for offline play)
- `privacy.html`, `support.html` – App Store Connect Privacy Policy URL and Support URL
- `resources/icon.png` – 1024×1024 app icon
- `.github/workflows/ios-release.yml` – builds on GitHub's macOS runners and uploads to TestFlight on every push to `main`

Bundle ID `com.ryan.boxsmash`. Secrets needed: `APP_STORE_CONNECT_KEY_ID`, `APP_STORE_CONNECT_ISSUER_ID`, `APP_STORE_CONNECT_API_KEY`.
