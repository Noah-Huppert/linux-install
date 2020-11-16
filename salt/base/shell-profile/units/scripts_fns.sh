# Load script repository functions into shell

# Load script repository functions into shell
files=($({{ pillar.scripts_repo.directory }}/load-functions.sh))

for file in "${files[@]}"; do
    . "$file"
done
