#import <Foundation/Foundation.h>
#import <Capacitor/Capacitor.h>

// Registers the Swift class with Capacitor under the name "BoxBoard".
CAP_PLUGIN(BoxBoardPlugin, "BoxBoard",
    CAP_PLUGIN_METHOD(submit, CAPPluginReturnPromise);
    CAP_PLUGIN_METHOD(load, CAPPluginReturnPromise);
)
