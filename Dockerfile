# Use the official .NET SDK image as a build stage
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /app

# Copy the .csproj file and restore any dependencies
COPY *.csproj .
RUN dotnet restore

# Copy the rest of the application code and build
COPY . .
RUN dotnet publish -c Release -o out

# Use the official .NET runtime image for the final stage
FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS runtime
WORKDIR /app
COPY --from=build /app/out .
ENTRYPOINT ["dotnet", "MyMicroservice.dll"]

