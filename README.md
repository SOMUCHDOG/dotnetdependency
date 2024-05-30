# dotnetdependency
Bash script to parse any number of dotnet projects and create files indicating dependencies

## Usage

Clone the repo

In a shell you will need to modify the files ownership to allow it to execute

```
chmod +x dependencies.sh
```

Then run the file
```
./dependencies.sh
```

It will prompt you for the directory path you would like to recursively search. This can be a parent directory of many projects or a single project.

This needs to be the fullpath.
