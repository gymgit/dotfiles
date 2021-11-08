import os
# https://ops.tips/gists/navigating-the-linux-kernel-source-with-youcompleteme/
CURRENT_DIR = os.path.dirname(os.path.abspath(__file__))


# include_dirs = [
#     './arch/x86/include',
#     './arch/x86/include/generated',
#     './arch/x86/include/generated/uapi',
#     './arch/x86/include/uapi',
#     './include',
#     './include/generated/uapi',
#     './include/uapi',
# ]
include_dirs = [
    './arch/arm64/include',
    './arch/arm64/include/generated',
    './arch/arm64/include/generated/uapi',
    './arch/arm64/include/uapi',
    './include',
    './include/generated/uapi',
    './include/uapi',
]

include_files = [
    './include/linux/kconfig.h',
]

flags = [
    '-D__KERNEL__',
    '-std=gnu89',
    '-xc',
    '-nostdinc',
]

def FlagsForFile( filename, **kwargs ):
    """
    Given a source file, retrieves the flags necessary for compiling it.
    """
    for dir in include_dirs:
        flags.append('-I' + os.path.join(CURRENT_DIR, dir))

    for file in include_files:
        flags.append('-include ' + os.path.join(CURRENT_DIR, file))

    return { 'flags': flags }
