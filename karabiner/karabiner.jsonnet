local _caps_manipulator(from, to) = {
  conditions: [{ name: 'caps_lock pressed', type: 'variable_if', value: 1 }],
  from: { key_code: from, modifiers: { optional: ['any'] } },
  to: [{ key_code: to }],
  type: 'basic',
};
local _swap_ctrl_option(key) = {
  from: { key_code: key, modifiers: { mandatory: ['control'] } },
  to: [{ key_code: key, modifiers: ['option'] }],
  type: 'basic',
};
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
        rules: [
          {
            description: 'CAPS LOCK + hjkl to arrow keys',
            manipulators: [
              _caps_manipulator('h', 'left_arrow'),
              _caps_manipulator('j', 'down_arrow'),
              _caps_manipulator('k', 'up_arrow'),
              _caps_manipulator('l', 'right_arrow'),
              _caps_manipulator('i', 'home'),
              _caps_manipulator('n', 'end'),
              {
                from: { key_code: 'caps_lock', modifiers: { optional: ['any'] } },
                to: [{ set_variable: { name: 'caps_lock pressed', value: 1 } }],
                to_after_key_up: [{ set_variable: { name: 'caps_lock pressed', value: 0 } }],
                type: 'basic',
              },
            ],
          },
          {
            description: 'Ctrl + BS/Del Keys to Option + BS/Del Keys',
            manipulators: std.map(_swap_ctrl_option, ['delete_or_backspace', 'delete_forward']),
          },
          {
            description: 'Ctrl + Arrow Keys to Option + Arrow Keys',
            manipulators: std.map(_swap_ctrl_option, ['up_arrow', 'down_arrow', 'left_arrow', 'right_arrow']),
          },
        ],
      },
      devices: [
        {
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
          simple_modifications: [
            {
              from: {
                key_code: 'caps_lock',
              },
              to: [
                {
                  key_code: 'right_command',
                },
              ],
            },
          ],
          treat_as_built_in_keyboard: false,
        },
        {
          disable_built_in_keyboard_if_exists: false,
          fn_function_keys: [],
          identifiers: {
            is_keyboard: true,
            is_pointing_device: false,
            product_id: 641,
            vendor_id: 1452,
          },
          ignore: false,
          manipulate_caps_lock_led: true,
          simple_modifications: [],
          treat_as_built_in_keyboard: false,
        },
        {
          disable_built_in_keyboard_if_exists: false,
          fn_function_keys: [],
          identifiers: {
            is_keyboard: false,
            is_pointing_device: true,
            product_id: 641,
            vendor_id: 1452,
          },
          ignore: true,
          manipulate_caps_lock_led: false,
          simple_modifications: [],
          treat_as_built_in_keyboard: false,
        },
        {
          disable_built_in_keyboard_if_exists: false,
          fn_function_keys: [],
          identifiers: {
            is_keyboard: true,
            is_pointing_device: true,
            product_id: 321,
            vendor_id: 1241,
          },
          ignore: true,
          manipulate_caps_lock_led: true,
          simple_modifications: [],
          treat_as_built_in_keyboard: false,
        },
        {
          disable_built_in_keyboard_if_exists: false,
          fn_function_keys: [],
          identifiers: {
            is_keyboard: true,
            is_pointing_device: false,
            product_id: 321,
            vendor_id: 1241,
          },
          ignore: false,
          manipulate_caps_lock_led: true,
          simple_modifications: [],
          treat_as_built_in_keyboard: false,
        },
        {
          disable_built_in_keyboard_if_exists: false,
          fn_function_keys: [],
          identifiers: {
            is_keyboard: true,
            is_pointing_device: false,
            product_id: 50475,
            vendor_id: 1133,
          },
          ignore: false,
          manipulate_caps_lock_led: true,
          simple_modifications: [],
          treat_as_built_in_keyboard: false,
        },
        {
          disable_built_in_keyboard_if_exists: false,
          fn_function_keys: [],
          identifiers: {
            is_keyboard: false,
            is_pointing_device: true,
            product_id: 50475,
            vendor_id: 1133,
          },
          ignore: true,
          manipulate_caps_lock_led: false,
          simple_modifications: [],
          treat_as_built_in_keyboard: false,
        },
      ],
      name: 'Default profile',
      parameters: {
        delay_milliseconds_before_open_device: 1000,
      },
      selected: true,
      simple_modifications: [],
      virtual_hid_keyboard: {
        country_code: 0,
        indicate_sticky_modifier_keys_state: true,
        mouse_key_xy_scale: 100,
      },
    },
  ],
}
