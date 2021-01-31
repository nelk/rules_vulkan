_shader_file_extensions = [
    '.vert',
    '.frag',
    '.tesc',
    '.tese',
    '.geom',
    '.comp',
    '.glsl',
    '.spvasm',
]

_shader_stages = [
    'vertex',
    'fragment',
    'tesscontrol',
    'tesseval',
    'geometry',
    'compute',
]

def _SpvOutput(srcs):
    return [src.basename + '.spv' for src in srcs]

def _SpvasmOutput(srcs):
    return [src.basename + '.spvasm' for src in srcs]

def _shader_binary(ctx):
    spvOut = ctx.actions.declare_file(ctx.attr.name + ".spv")

    glslcArgs = []

    if ctx.attr.stage:
        glslcArgs.append("-fshader-stage=" + ctx.attr.stage)

    glslcArgs.append('-c')
    glslcArgs.append(ctx.file.entry_point.path)

    glslcArgs.append('-o')
    glslcArgs.append(spvOut.path)

    ctx.actions.run(
        inputs = ctx.files.srcs,
        outputs = [spvOut],
        executable = ctx.executable.glslc,
        arguments = glslcArgs,
    )

    return DefaultInfo(files = depset([spvOut]))

shader_binary = rule(
    implementation = _shader_binary,
    attrs = {
        "entry_point": attr.label(
            mandatory = True,
            allow_single_file = True,
        ),
        "srcs": attr.label_list(
            mandatory = True,
            allow_files = _shader_file_extensions,
        ),
        "stage": attr.string(
            default = '',
            values = [''] + _shader_stages,
        ),
        "glslc": attr.label(
            default = Label("@vulkan_sdk//:glslc"),
            allow_single_file = True,
            executable = True,
            cfg = "host",
        ),
    },
)
