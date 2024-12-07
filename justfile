set shell := ["C:\\Program Files\\PowerShell\\7\\pwsh.exe", "-c"]

build:
    cd src && dotnet build && docker build . -t localhost:5000/yeseh/rad-orleans && docker push localhost:5000/yeseh/rad-orleans

run: build
    rad run app.bicep

publish: build
