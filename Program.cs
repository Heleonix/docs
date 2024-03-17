using System;
using System.Diagnostics;

using var process = Process.Start(new ProcessStartInfo
{
    FileName = "dotnet",
    Arguments = "docfx serve ../../../docs",
});

using var process2 = Process.Start(new ProcessStartInfo
{
    FileName = "http://localhost:8080",
    UseShellExecute = true
});
