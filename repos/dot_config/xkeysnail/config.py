# -*- coding: utf-8 -*-

import re
from xkeysnail.transform import *

## chrome
define_keymap(re.compile("Google-chrome"), {
    K("M-w"): K("C-F4"),
    K("M-l"): K("C-l"),
    K("M-t"): K("C-t"),
    K("M-Shift-t"): K("C-Shift-t"),
    K("M-r"): K("C-r"),

    K("M-Shift-n"): K("C-Shift-n"),
    K("M-Shift-LEFT_BRACE"): K("C-Shift-Tab"),
    K("M-Shift-RIGHT_BRACE"): K("C-Tab"),
}, "01-chrome")

## terminal
define_keymap(re.compile("Gnome-terminal|Tilix"), {
    K("M-c"): K("C-Shift-c"),
    K("M-v"): K("C-Shift-v"),
    K("M-n"): K("C-Shift-n"),
    K("M-t"): K("C-Shift-t"),
    K("M-Shift-LEFT_BRACE"): K("C-PAGE_UP"),
    K("M-Shift-RIGHT_BRACE"): K("C-PAGE_DOWN"),
}, "01-terminal")

define_keymap(lambda wm_class: wm_class not in ("Gnome-terminal|Tilix|jetbrains-idea"), {
    K("M-c"): K("C-c"),
    K("M-x"): K("C-x"),
    K("M-z"): K("C-z"),
    K("M-Shift-z"): K("C-Shift-z"),
    K("M-v"): K("C-v"),
    K("M-w"): K("C-w"),
    K("M-n"): K("C-n"),
    K("M-f"): K("C-f"),
    K("M-a"): K("C-SLASH"), # gtk-key-theme = emacs を設定している前提
    K("M-Shift-UP"): K("C-Shift-HOME"),
    K("M-Shift-Down"): K("C-Shift-END"),
    K("M-Shift-Right"): K("Shift-END"),
    K("M-Shift-Left"): K("Shift-HOME"),
    K("M-q"): K("M-F4"),
}, "98-partial-global")

define_keymap(None, {
    K("LC-SEMICOLON"): K("BACKSPACE"),
    K("LC-q"): K("ESC"),
}, "99-global")

# intellij
define_conditional_modmap(lambda wm_class: wm_class in ("jetbrains-idea"), {
    Key.LEFT_ALT: Key.LEFT_META,
    Key.LEFT_META: Key.LEFT_ALT,
    Key.CAPSLOCK: Key.LEFT_CTRL,
    Key.RIGHT_CTRL: Key.ESC,
})

define_modmap({
    Key.CAPSLOCK: Key.LEFT_CTRL,
    Key.RIGHT_CTRL: Key.ESC,
})

#define_keymap(re.compile("jetbrains-idea"), {
#    K("Super-n"): K("C-n"),
#}, "jetbrains-idea")

#define_conditional_multipurpose_modmap(lambda wm_class: wm_class in ("jetbrains-idea"), {
#    # meta キーを alt の位置のキーへ変更
#    Key.LEFT_ALT: [Key.LEFT_ALT, Key.LEFT_META],
#    Key.LEFT_META: [ Key.LEFT_META, Key.LEFT_ALT],
#})

