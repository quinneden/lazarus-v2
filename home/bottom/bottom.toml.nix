{
  config,
  inputs,
  outputs,
  spaghetti,
  ...
}: {
  # write btm config with nix-colors added
  home-manager.users.${spaghetti.user}.home.file.".config/bottom/bottom.toml" = {
    text = ''
      # This is a default config file for bottom.  All of the settings are commented
      # out by default; if you wish to change them uncomment and modify as you see
      # fit.

      # This group of options represents a command-line flag/option.  Flags explicitly
      # added when running (ie: btm -a) will override this config file if an option
      # is also set here.

      [flags]

      # Defaults to Celsius.  Temperature is one of: k f or c mmmm kfc
      temperature_type = "c"

      # Whether to group processes with the same name together by default.
      group_processes = true

      # Whether to hide the average cpu entry.
      hide_avg_cpu = true

      # Whether to use dot markers rather than braille.
      dot_marker = true

      # The update rate of the application.
      rate = "1s"

      # Whether to put the CPU legend to the left.
      left_legend = false

      # Use basic mode
      basic = false

      # Whether to set CPU% on a process to be based on the total CPU or just current usage.
      #current_usage = false
      # Whether to set CPU% on a process to be based on the total CPU or per-core CPU% (not divided by the number of cpus).
      #unnormalized_cpu = false
      # Whether to make process searching case sensitive by default.
      #case_sensitive = false
      # Whether to make process searching look for matching the entire word by default.
      #whole_word = false
      # Whether to make process searching use regex by default.
      #regex = false
      # The default time interval (in milliseconds).
      #default_time_value = "60s"
      # The time delta on each zoom in/out action (in milliseconds).
      #time_delta = 15000
      # Hides the time scale.
      #hide_time = false
      # Override layout default widget
      #default_widget_type = "proc"
      #default_widget_count = 1
      # Expand selected widget upon starting the app
      #expanded_on_startup = true
      # Use the old network legend style
      #use_old_network_legend = false
      # Remove space in tables
      #hide_table_gap = false
      # Show the battery widgets
      battery = true
      # Disable mouse clicks
      #disable_click = false
      # Built-in themes.  Valid values are "default", "default-light", "gruvbox", "gruvbox-light", "nord", "nord-light"
      #color = "default"
      # Show memory values in the processes widget as values by default
      #mem_as_value = false
      # Show tree mode by default in the processes widget.
      #tree = false
      # Shows an indicator in table widgets tracking where in the list you are.
      #show_table_scroll_position = false
      # Show processes as their commands by default in the process widget.
      #process_command = false
      # Displays the network widget with binary prefixes.
      #network_use_binary_prefix = false
      # Displays the network widget using bytes.
      #network_use_bytes = false
      # Displays the network widget with a log scale.
      #network_use_log = false
      # Hides advanced options to stop a process on Unix-like systems.
      #disable_advanced_kill = false
      # Shows GPU(s) memory
      enable_gpu_memory = true
      # Shows cache and buffer memory
      enable_cache_memory = true
      # How much data is stored at once in terms of time.
      #retention = "10m"

      # These are flags around the process widget.

      #[processes]
      #columns = ["PID", "Name", "CPU%", "Mem%", "R/s", "W/s", "T.Read", "T.Write", "User", "State"]

      # These are all the components that support custom theming.  Note that colour support
      # will depend on terminal support.

      [colors]
      # Represents the colour of table headers (processes, CPU, disks, temperature).
      table_header_color="#${config.colorscheme.palette.base05}"
      # Represents the colour of the label each widget has.
      widget_title_color="#${config.colorscheme.palette.base05}"
      # Represents the average CPU color.
      avg_cpu_color="#${config.colorscheme.palette.base0F}"
      # Represents the colour the core will use in the CPU legend and graph.
      cpu_core_colors=["#${config.colorscheme.palette.base0A}", "#${config.colorscheme.palette.base0B}", "#${config.colorscheme.palette.base0C}", "#${config.colorscheme.palette.base0D}", "#${config.colorscheme.palette.base0E}", "#${config.colorscheme.palette.base0F}"]
      # Represents the colour RAM will use in the memory legend and graph.
      ram_color="#${config.colorscheme.palette.base0E}"
      # Represents the colour SWAP will use in the memory legend and graph.
      swap_color="#${config.colorscheme.palette.base0B}"
      # Represents the colour ARC will use in the memory legend and graph.
      #arc_color="LightCyan"
      # Represents the colour the GPU will use in the memory legend and graph.
      #gpu_core_colors=["LightGreen", "LightBlue", "LightRed", "Cyan", "Green", "Blue", "Red"]
      # Represents the colour rx will use in the network legend and graph.
      rx_color="#${config.colorscheme.palette.base0D}"
      # Represents the colour tx will use in the network legend and graph.
      tx_color="#${config.colorscheme.palette.base0B}"
      # Represents the colour of the border of unselected widgets.
      border_color="#${config.colorscheme.palette.base04}"
      # Represents the colour of the border of selected widgets.
      highlighted_border_color="#${config.colorscheme.palette.base0D}"
      # Represents the colour of most text.
      text_color="#${config.colorscheme.palette.base06}"
      # Represents the colour of text that is selected.
      selected_text_color="#${config.colorscheme.palette.base00}"
      # Represents the background colour of text that is selected.
      selected_bg_color="#${config.colorscheme.palette.base0D}"
      # Represents the colour of the lines and text of the graph.
      graph_color="#${config.colorscheme.palette.base06}"
      # Represents the colours of the battery based on charge
      high_battery_color="#${config.colorscheme.palette.base0B}"
      medium_battery_color="#${config.colorscheme.palette.base0E}"
      low_battery_color="#${config.colorscheme.palette.base0F}"

      # Layout - layouts follow a pattern like this:
      # [[row]] represents a row in the application.
      # [[row.child]] represents either a widget or a column.
      # [[row.child.child]] represents a widget.
      #
      # All widgets must have the type value set to one of ["cpu", "mem", "proc", "net", "temp", "disk", "empty"].
      # All layout components have a ratio value - if this is not set, then it defaults to 1.
      # The default widget layout:
      #[[row]]
      #  ratio=30
      #  [[row.child]]
      #  type="cpu"
      #[[row]]
      #    ratio=40
      #    [[row.child]]
      #      ratio=4
      #      type="mem"
      #    [[row.child]]
      #      ratio=3
      #      [[row.child.child]]
      #        type="temp"
      #      [[row.child.child]]
      #        type="disk"
      #[[row]]
      #  ratio=30
      #  [[row.child]]
      #    type="net"
      #  [[row.child]]
      #    type="proc"
      #    default=true


      # Filters - you can hide specific temperature sensors, network interfaces, and disks using filters.  This is admittedly
      # a bit hard to use as of now, and there is a planned in-app interface for managing this in the future:
      #[disk_filter]
      #is_list_ignored = true
      #list = ["/dev/sda\\d+", "/dev/nvme0n1p2"]
      #regex = true
      #case_sensitive = false
      #whole_word = false

      #[mount_filter]
      #is_list_ignored = true
      #list = ["/mnt/.*", "/boot"]
      #regex = true
      #case_sensitive = false
      #whole_word = false

      #[temp_filter]
      #is_list_ignored = true
      #list = ["cpu", "wifi"]
      #regex = false
      #case_sensitive = false
      #whole_word = false

      #[net_filter]
      #is_list_ignored = true
      #list = ["virbr0.*"]
      #regex = true
      #case_sensitive = false
      #whole_word = false

    '';
  };
}
