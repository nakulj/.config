local array(x) = if std.isArray(x) then x else [x];
local manipulators(i, conditions=null) = std.map(
  function(x) (
    x {
      type: 'basic',
      to: array(x.to),
    } + std.prune({ conditions: array(conditions) })
  ),
  i
);
local event(key_code, extra={}) = extra { key_code: key_code };
local anyModifier = { modifiers: { optional: ['any'] } };
local swap_modifier(from, to, key_code) = {
  from: event(key_code, { modifiers: { mandatory: array(from) } }),
  to: event(key_code, { modifiers: array(to) }),
};
local arrows = ['up_arrow', 'down_arrow', 'left_arrow', 'right_arrow'];
local swap_arrow_modfiers(from, to) = manipulators(std.map(function(arrow) swap_modifier(from, to, arrow), arrows));
local set_caps_pressed(v) = { set_variable: { name: 'caps_lock pressed', value: v } };

{
  global: {
    check_for_updates_on_startup: true,
    show_in_menu_bar: true,
    show_profile_name_in_menu_bar: false,
  },
  profiles: [
    {
      complex_modifications: {
        parameters: {
          'basic.simultaneous_threshold_milliseconds': 50,
          'basic.to_delayed_action_delay_milliseconds': 500,
          'basic.to_if_alone_timeout_milliseconds': 1000,
          'basic.to_if_held_down_threshold_milliseconds': 500,
          'mouse_motion_to_scroll.speed': 100,
        },
        rules: [{
          description: 'CAPS LOCK + hjkl to arrow keys',
          manipulators: manipulators(
                          [{
                            from: event('j', anyModifier),
                            to: event('down_arrow'),
                          }, {
                            from: event('k', anyModifier),
                            to: event('up_arrow'),
                          }, {
                            from: event('h', anyModifier),
                            to: event('left_arrow'),
                          }, {
                            from: event('l', anyModifier),
                            to: event('right_arrow'),
                          }],
                          conditions={
                            name: 'caps_lock pressed',
                            type: 'variable_if',
                            value: 1,
                          }
                        ) +
                        manipulators([{
                          from: event('caps_lock', anyModifier),
                          to: set_caps_pressed(1),
                          to_after_key_up: [set_caps_pressed(0)],
                        }]),
        }, {
          description: 'Custom Home/End',
          manipulators: manipulators([
            { from: event('i', anyModifier), to: event('home') },
            { from: event('n', anyModifier), to: event('end') },
          ], conditions={
            name: 'caps_lock pressed',
            type: 'variable_if',
            value: 1,

          }),
        }, {
          description: 'Ctrl + Arrow Keys to Option + Arrow Keys',
          manipulators: swap_arrow_modfiers('control', 'option'),
        }, {
          description: 'Swap Command with Ctrl',
          manipulators: manipulators(
            [{
              from: event('left_command', anyModifier),
              to: event('left_control'),
            }, {
              from: event('left_control', anyModifier),
              to: event('left_command'),
            }, {
              from: event('left_shift', anyModifier),
              to: event('left_shift', { lazy: true }),
            }, {
              from: event('right_command', anyModifier),
              to: event('right_control'),
            }, {
              from: event('right_control', anyModifier),
              to: event('right_command'),
            }, {
              from: event('right_shift', anyModifier),
              to: event('right_shift', { lazy: true }),
            }],
          ),
        }, {
          description: 'Cmd + Arrow Keys to Option + Arrow Keys',
          manipulators: swap_arrow_modfiers('command', 'option'),
        }, {
          description: 'Ctrl + Shift + Arrow Keys to Option + Shift + Arrow Keys',
          manipulators: swap_arrow_modfiers(['control', 'shift'], ['option', 'shift']),
        }, {
          description: 'Cmd + Shift + Arrow Keys to Option + Shift + Arrow Keys',
          manipulators: swap_arrow_modfiers(['command', 'shift'], ['option', 'shift']),
        }, {
          description: 'Ctrl + BS/Del Keys to Option + BS/Del Keys',
          manipulators: manipulators([
            swap_modifier('control', 'option', 'delete_or_backspace'),
            swap_modifier('control', 'option', 'delete_forward'),
          ]),
        }, {
          description: 'Cmd + BS/Del Keys to Option + BS/Del Keys',
          manipulators: manipulators([
            swap_modifier('command', 'option', 'delete_or_backspace'),
            swap_modifier('command', 'option', 'delete_forward'),
          ]),
        }, {
          description: 'PC like home/end',
          manipulators: manipulators([{
            from: event('home'),
            to: event('left_arrow', { modifiers: 'command' }),
          }, {
            from: event('end'),
            to: event('right_arrow', { modifiers: 'command' }),
          }] ),
        }],
      },
      devices: [{
        disable_built_in_keyboard_if_exists: false,
        fn_function_keys: [],
        identifiers: {
          is_keyboard: true,
          is_pointing_device: false,
          product_id: 635,
          vendor_id: 1452,
        },
        ignore: false,
        manipulate_caps_lock_led: true,
        simple_modifications: [{
          from: { key_code: 'caps_lock' },
          to: { key_code: 'right_command' },
        }],
      }],
      fn_function_keys: std.mapWithIndex(
        function(i, to) { from: { key_code: std.format('f%d', (i + 1)) }, to: to },
        [
          { consumer_key_code: 'display_brightness_decrement' },
          { consumer_key_code: 'display_brightness_increment' },
          { key_code: 'mission_control' },
          { key_code: 'launchpad' },
          { key_code: 'illumination_decrement' },
          { key_code: 'illumination_increment' },
          { consumer_key_code: 'rewind' },
          { consumer_key_code: 'play_or_pause' },
          { consumer_key_code: 'fastforward' },
          { consumer_key_code: 'mute' },
          { consumer_key_code: 'volume_decrement' },
          { consumer_key_code: 'volume_increment' },
        ]
      ),
      name: 'Default profile',
      parameters: { delay_milliseconds_before_open_device: 1000 },
      selected: true,
      simple_modifications: [],
      virtual_hid_keyboard: {
        country_code: 0,
        mouse_key_xy_scale: 100,
      },
    },
  ],
}
