#!/bin/bash

# Prompt the user to input the root directory containing all repositories
read -p "Please enter the path to the root directory containing all repositories: " root_directory

# Navigate to the root directory
cd "$root_directory" || { echo "Directory not found. Exiting."; exit 1; }

# Create the output files or make sure they are empty
> connectionstrings.txt
> csproj_dependencies.txt
> packages_dependencies.txt
> vbproj_dependencies.txt
> packages_dependencies.txt

# Function to search for dependencies in .csproj files
find_csproj_dependencies() {
  grep -r -i -n --include \*.csproj "<PackageReference Include=" ./ | sort | uniq | sed 's/$/\r/' > csproj_dependencies.txt
  grep -r -i -n --include \*.csproj "<Reference Include=" ./ | sort | uniq | sed 's/$/\r/' > csproj_dependencies.txt
}

# Function to search for dependencies in .vbproj files
find_vbproj_dependencies() {
  grep -r -i -n --include \*.vbproj "<PackageReference Include=" ./ | sort | uniq | sed 's/$/\r/' > vbproj_dependencies.txt
  grep -r -i -n --include \*.vbproj "<Reference Include=" ./ | sort | uniq | sed 's/$/\r/' > vbproj_dependencies.txt
}

# Function to search for dependencies in packages.config files
find_packages_dependencies() {
  grep -r -i -n --include \*packages.config "<package id=" ./ | sort | uniq | sed 's/$/\r/' > packages_dependencies.txt
}

# Function to search for target frameworks in .csproj and .vbproj files
find_frameworks() {
  grep -r -i -n --include \*.csproj "<TargetFramework>" ./ | sort | uniq | sed 's/$/\r/' > frameworks.txt
  grep -r -i -n --include \*.vbproj "<TargetFramework>" ./ | sort | uniq | sed 's/$/\r/' > frameworks.txt
}

# Function to search for database connection strings
find_connections() {
  grep -r -i -n "data source=" ./ | sort | uniq | sed 's/$/\r/' > connectionstrings.txt
}

# Run the functions
find_connections
find_csproj_dependencies
find_vbproj_dependencies
find_packages_dependencies
find_frameworks

# Combine results into a single file (optional)
cat csproj_dependencies.txt vbproj_dependencies.txt packages_dependencies.txt frameworks.txt > all_dependencies_and_frameworks.txt

# Notify the user
echo "Dependencies and frameworks have been extracted and saved to csproj_dependencies.txt, vbproj_dependencies.txt, packages_dependencies.txt, frameworks.txt, and all_dependencies_and_frameworks.txt"
