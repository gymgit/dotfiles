import os
import ycm_core
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
    './include/linux',
    './include/asm-generic',
]

include_files = [
    #'./include/linux/kconfig.h',
]

flags = [
'-Wall',
'-Wextra',
'-Wc++98-compat',
'-D__KERNEL__',
'-nostdinc',
#'-march=armv7-a',
'-DUSE_CLANG_COMPLETER',
# THIS IS IMPORTANT! Without a "-std=<something>" flag, clang won't know which
# language to use when compiling headers. So it will guess. Badly. So C++
# headers will be compiled as C headers. You don't want that so ALWAYS specify
# a "-std=<something>".
# For a C project, you would set this to something like 'c99' instead of
# 'c++11'.
'-std=c99',
# ...and the same thing goes for the magic -x option which specifies the
# language that the files to be compiled are written in. This is mostly
# relevant for c++ headers.
# For a C project, you would set this to 'c' instead of 'c++'.
'-x', 'c',
'-I', '.'
]

# def FlagsForFile( filename, **kwargs ):
#     """
#     Given a source file, retrieves the flags necessary for compiling it.
#     """
#     for dir in include_dirs:
#         flags.append('-I' + os.path.join(CURRENT_DIR, dir))
#
#     for file in include_files:
#         flags.append('-include ' + os.path.join(CURRENT_DIR, file))
#
#     return { 'flags': flags }


def GetRoot(filename, marker_dir):
    path = os.path.dirname(os.path.abspath(filename))
    while True:
        if os.path.ismount(path):
            return None
        if os.path.isdir(os.path.join(path, marker_dir)):
            return path
        path = os.path.dirname(path)

def AppendIncludes(filename):
    kernelroot = GetRoot(filename, "Kbuild")
    for includedir in include_dirs:
        flags.append('-isystem')
        flags.append(os.path.join(kernelroot, includedir))
    for incfile in include_files:
        flags.append('-include')
        flags.append(os.path.join(kernelroot, incfile))
    flags.append('-I')
    flags.append(os.path.dirname(os.path.abspath(filename)))

# Set this to the absolute path to the folder (NOT the file!) containing the
# compile_commands.json file to use that instead of 'flags'. See here for
# more details: http://clang.llvm.org/docs/JSONCompilationDatabase.html
#
# Most projects will NOT need to set this to anything; you can just change the
# 'flags' list of compilation flags. Notice that YCM itself uses that approach.
compilation_database_folder = ''

if compilation_database_folder:
  database = ycm_core.CompilationDatabase( compilation_database_folder )
else:
  database = None


def DirectoryOfThisScript():
  return os.path.dirname( os.path.abspath( __file__ ) )


def MakeRelativePathsInFlagsAbsolute( flags, working_directory ):
  if not working_directory:
    return list( flags )
  new_flags = []
  make_next_absolute = False
  path_flags = [ '-isystem', '-I', '-iquote', '--sysroot=' ]
  for flag in flags:
    new_flag = flag

    if make_next_absolute:
      make_next_absolute = False
      if not flag.startswith( '/' ):
        new_flag = os.path.join( working_directory, flag )

    for path_flag in path_flags:
      if flag == path_flag:
        make_next_absolute = True
        break

      if flag.startswith( path_flag ):
        path = flag[ len( path_flag ): ]
        new_flag = path_flag + os.path.join( working_directory, path )
        break

    if new_flag:
      new_flags.append( new_flag )
  return new_flags


def FlagsForFile( filename ):
  if database:
    # Bear in mind that compilation_info.compiler_flags_ does NOT return a
    # python list, but a "list-like" StringVec object
    compilation_info = database.GetCompilationInfoForFile( filename )
    final_flags = MakeRelativePathsInFlagsAbsolute(
      compilation_info.compiler_flags_,
      compilation_info.compiler_working_dir_ )

    # NOTE: This is just for YouCompleteMe; it's highly likely that your project
    # does NOT need to remove the stdlib flag. DO NOT USE THIS IN YOUR
    # ycm_extra_conf IF YOU'RE NOT 100% YOU NEED IT.
    try:
      final_flags.remove( '-stdlib=libc++' )
    except ValueError:
      pass
  else:
    relative_to = DirectoryOfThisScript()
    AppendIncludes(filename)
    final_flags = MakeRelativePathsInFlagsAbsolute( flags, relative_to )

  return {
    'flags': final_flags,
    'do_cache': True
  }
