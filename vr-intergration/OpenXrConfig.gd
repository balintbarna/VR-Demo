extends Reference
class_name OpenXrConfig

func config(viewport: Viewport) -> bool:
    var interface = ARVRServer.find_interface("OpenXR")
    if interface and interface.initialize():

        # var refresh_rates = ovr_display.get_supported_display_refresh_rates()
        # print("Supported refresh rates:" + str(refresh_rates))

        # var highest_rate = refresh_rates[len(refresh_rates) - 1]
        var highest_rate = 72
        Engine.iterations_per_second = highest_rate
        Engine.target_fps = highest_rate
        print("Rates set to " + str(highest_rate))

        viewport.arvr = true
        viewport.keep_3d_linear = true
        OS.vsync_enabled = false
        InputMapper.mapping = OpenXrInputMapping.new()
        print("OpenXR runtime configured")
        return true
    return false