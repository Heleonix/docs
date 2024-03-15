# Heleonix.Build

[![Release: .NET / NuGet](https://github.com/Heleonix/Heleonix.Build/actions/workflows/release-net-nuget.yml/badge.svg)](https://github.com/Heleonix/Heleonix.Build/actions/workflows/release-net-nuget.yml)

The MSBuild-based build framework for applications on CI/CD systems.

## Install

https://www.nuget.org/packages/Heleonix.Build

## The idea

This framework is aiming to simplify implementation of different CI/CD stages for applications on CI/CD systems,
like GoCD, Jenkins, TeamCity etc.

The build framework consists of parameterized MSBuild [targets](xref:Heleonix.Build), such as <xref:Hx_NetBuild>, <xref:Hx_NetTest>, <xref:Hx_NetValidate> etc.,
which usually represent separate steps in CI pipelines.

The build framework also provides set of reusable <xref:Heleonix.Build.Tasks>.

Usually source code is organized by following some well-known or custom standards, that's why this build framework
supports solid customization. Basically it follows the "configurable conventions" approach.

Default values of properties of <xref:Heleonix.Build> targets follow well-known practices of arrangement of source code.
So, if you follow well-known standards too, you do not even neeed to write custom build scripts.

## More details

- [Usage](usage.md)
- [Extensibility](extensibility.md)
- [API](api/Heleonix.Build.xsd)
