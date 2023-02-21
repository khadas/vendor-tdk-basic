package tdk

import (
    "android/soong/android"
    "android/soong/cc"
    //"fmt"
    "github.com/google/blueprint/proptools"
    "strconv"
)

func init() {
    //fmt.Println("init");
    android.RegisterModuleType("tdk_variant", TdkVariantDefaultsFactory)
    android.RegisterModuleType("tdk_systemext", TdkSysExtDefaultsFactory)
}

func TdkVariantDefaultsFactory() (android.Module) {
    module := cc.DefaultsFactory()
    android.AddLoadHook(module, TdkVariantDefaults)
    return module
}

func TdkSysExtDefaultsFactory() (android.Module) {
    module := cc.DefaultsFactory()
    android.AddLoadHook(module, TdkSysExtDefaults)
    return module
}

func TdkVariantDefaults(ctx android.LoadHookContext) {
    type props struct {
        Target struct {
            Android struct {
                Enabled *bool
            }
        }
    }
    p := &props{}
    p.Target.Android.Enabled = new(bool)
    if ctx.AConfig().Getenv("TARGET_BUILD_VARIANT") == "userdebug" {
        *p.Target.Android.Enabled = true
    } else if ctx.AConfig().Getenv("TARGET_BUILD_VARIANT") == "eng" {
        *p.Target.Android.Enabled = true
    } else {
        *p.Target.Android.Enabled = false
    }

    ctx.AppendProperties(p)
}

func TdkSysExtDefaults(ctx android.LoadHookContext) {
    AndroidVersion := ctx.AConfig().PlatformVersionName()
    AndroidVersionInt,err := strconv.Atoi(AndroidVersion)
    if err != nil {
        //fmt.Printf("%v fail to convert", AndroidVersionInt)
    } else {
        //fmt.Println("CheckDefaults AndroidVersion:", AndroidVersionInt)
    }
    if AndroidVersionInt > 10 {
        type props struct {
            System_ext_specific  *bool
        }
        p := &props{}
        p.System_ext_specific = proptools.BoolPtr(true)
        ctx.AppendProperties(p)
    }
}
