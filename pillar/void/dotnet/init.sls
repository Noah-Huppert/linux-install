dotnet:
  pkgs:
    - msbuild-bin
  
  sdk_url: https://download.visualstudio.microsoft.com/download/pr/1d2007d3-da35-48ad-80cc-a39cbc726908/1f3555baa8b14c3327bb4eaa570d7d07/dotnet-sdk-6.0.403-linux-x64.tar.gz
  sdk_sha: 779b3e24a889dbb517e5ff5359dab45dd3296160e4cb5592e6e41ea15cbf87279f08405febf07517aa02351f953b603e59648550a096eefcb0a20fdaf03fadde

  sdk_dir: /usr/share/dotnet
  link:
    source: /usr/share/dotnet/dotnet
    destination: /usr/local/bin/dotnet