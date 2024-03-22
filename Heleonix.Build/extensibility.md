# Extensibility

## Global properties

Global properties are defined out of targets, so they can be overriden in your custom *.hxbproj files out of targets
or from the command line.

### Naming convention

`<Ns><_Sys | _WS | _Run>_<PropertyName>[Dir(s) | File(s) | Url(s) | <Ext>]`

`Ns` - namespace abbreviation of your project/company etc.

`Sys` - system property, like path to the `dotnet.exe`.

`WS` - workspace-level or workspace-related property, i.e. property related to the repository being built.

`Run` - property related to a particular pipeline run (execution, iteration, increment etc.), i.e. build counter etc.

### Integration

A new global property should have defined default value (if applicable) in the
[Heleonix.Build.hxbproj](https://github.com/Heleonix/Heleonix.Build/blob/master/src/Heleonix.Build/Heleonix.Build.hxbproj)
and printed to the output (if applicable) in the [Hx_Initialize](https://github.com/Heleonix/Heleonix.Build/blob/master/src/Heleonix.Build/Heleonix.Build.hxbproj#L57) target.

### Documentation and IntelliSense

A new global property should be documented in the
[Heleonix.Build.xsd](https://github.com/Heleonix/Heleonix.Build/blob/master/src/Heleonix.Build/Schemas/Heleonix.Build.xsd).

## Targets

It is possible to create custom targets in addition to those provided by the build framework.
They can be created as contribution to the build framework or can be used in your own pipelines.

### Naming convention

#### Target name

`<Ns>_<TargetName>[_Variation]`

`Variation` in the name allows to define multiple real targets with some specific implementations under the same virtual `<Ns>_<TargetName>`.

For example, <xref:Hx_DocFX_Git> is the real target, which checks out, builds and commits documentation using git,
but the artifacts directory is `Hx_DocFX`. Also, there is no real target `Hx_DocFX`,
but in the future the target `Hx_DocFX_Svn` might be created.

There can be, however, properties or items defined with the name of the virtual target,
i.e `Hx_DocFX_Message`. In this case they are common for all the real targets.

Artifacts directory for all variations is the same

#### Target parameters

`<TargetName>_<ParameterName>[Dir(s) | File(s) | Url(s) | <Ext>]`

If a parameter represents a single instance of something, then it should be defined as an MSBuild property.

If a parameter represents multiple instances of something, then it should be defined as an MSBuild item and
the name usually should end with (s), if that makes sense.

#### Target private parameters

`_<TargetName>_<ParameterName>[Dir(s) | File(s) | <Ext>]`

### Target artifacts

The properties `<TargetName>_ArtifactsDir` define paths to artifacts directories and are defined outside of targets,
as the global properties, because targets can depend on each other via artifacts.
I.e. `Hx_ChangeLog_ArtifactsDir` is used by <xref:Hx_NetBuild>, <xref:Hx_NetNugetPush> etc.

Targets can depend on each other only via artifacts directories, because if every target is executed in a standalone `hxbuild` run,
then their properties and items are defined only within that particular `hxbuild` run. Artifacts directories can, however,
be uploaded and re-used between standalone `hxbuild` runs.

### Integration

In case of contribution, a new target needs to be placed in the
[Targets](https://github.com/Heleonix/Heleonix.Build/tree/master/src/Heleonix.Build/Targets) folder and included into the
[Targets](https://github.com/Heleonix/Heleonix.Build/blob/master/src/Heleonix.Build/Targets/Targets.targets) list.

Also, some unit test should be written to test key scenarios of usage and place in the
[Targets tests](https://github.com/Heleonix/Heleonix.Build/tree/master/test/Heleonix.Build.Tests/Targets).

### Documentation and IntelliSense

In case of contribution, the new target should be described in the `xsd` schema file and added to the existing
[Schemas](https://github.com/Heleonix/Heleonix.Build/tree/master/src/Heleonix.Build/Schemas/Targets)
and included into the [list of target schemas](https://github.com/Heleonix/Heleonix.Build/blob/master/src/Heleonix.Build/Schemas/Targets/Targets.xsd).
An example can be taken from any existing target, i.e. [Hx_NetBuild.xsd](https://github.com/Heleonix/Heleonix.Build/blob/master/src/Heleonix.Build/Schemas/Targets/Hx_NetBuild.xsd).

### Custom target template

```xml
<Project xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
  <PropertyGroup>
    <Ns_TargetName_ArtifactsDir>$(Hx_Run_ArtifactsDir)/TargetName</Ns_TargetName_ArtifactsDir>
  </PropertyGroup>

  <Target Name="Ns_TargetName">
    <Message Text="> RUNNING Ns_TargetName ..." Importance="high"/>

    <Hx_NetSetupTool DotnetExe="$(Hx_Sys_DotnetExe)" Name="NameOfFile">
      <Output TaskParameter="ToolPath" PropertyName="_Ns_TargetName_NameOfFileExe"/>
    </Hx_NetSetupTool>

    <!--Validation of required parameters-->

    <!--Target property groups, setting default vaues-->

    <!--Target item groups, setting default values-->

    <Message Text="> 1/3: Doing step one" Importance="high"/>
    <!--tasks, targets etc.-->
    <!--tasks, targets etc.-->

    <Message Text="> 2/3: Doing step two" Importance="high"/>
    <!--tasks, targets etc.-->
    <!--tasks, targets etc.-->

    <Message Text="> 3/3: Doing step three" Importance="high"/>
    <!--tasks, targets etc.-->
    <!--tasks, targets etc.-->

    <Message Text="> DONE Ns_TargetName" Importance="high"/>

    <OnError ExecuteTargets="Hx_OnError"/>
  </Target>
</Project>
```

## Tasks

It is possible to contribute to the build framework with a custom task.

### Naming convention

`<Ns>_<TaskName>`

`<TaskName>` is named in the format `Noun` `Verb`.

For example `Hx_FileCopy`, `Hx_FileRead`, `Hx_DirectoryClean` etc. Such naming approach is handy when the list of tasks
is alphabetically sorted in the Solution Expllorer, or when IntelliSense displays list of available tasks while typing a task name.

### Integration

A new task should inherit the [BaseTask](https://github.com/Heleonix/Heleonix.Build/blob/master/src/Heleonix.Build/Tasks/BaseTask.cs).

A new task should be placed in the [Tasks](https://github.com/Heleonix/Heleonix.Build/tree/master/src/Heleonix.Build/Tasks)
folder and listed in the [Tasks.tasks](https://github.com/Heleonix/Heleonix.Build/blob/master/src/Heleonix.Build/Tasks/Tasks.tasks).

A new task should be covered with a unit test with 100% of code coverage. The unit test should be placed in the
[Tasks tests](https://github.com/Heleonix/Heleonix.Build/tree/master/test/Heleonix.Build.Tests/Tasks).

### Documentation and IntelliSense

A new task should be documented in the `xsd` schema file and placed in the
[Tasks schemas](https://github.com/Heleonix/Heleonix.Build/tree/master/src/Heleonix.Build/Schemas/Tasks) folder.

The newly added task schema should be listed in the
[Tasks.xsd](https://github.com/Heleonix/Heleonix.Build/blob/master/src/Heleonix.Build/Schemas/Tasks/Tasks.xsd).