#!/bin/bash

# Function to extract essential output from Terraform plan
function extract_essential_output() {
  cat "$1" | sed -n '/Terraform used the selected providers/,/Terraform plan return code:/p'
}

# Function to escape special characters in a string
function escape_special_characters() {
  echo "$1" | sed 's/`/\\`/g; s/#/\\#/g'
}

# Function to comment on the PR using GitHub CLI
function comment_on_pr() {
  local body="$1"
  echo -e "$body" | gh pr comment "$pr_url" --body-file -
}

# Error handling for missing output file
if [[ ! -f "$output_file" ]]; then
  echo "Output file not found!"
  exit 1
fi

# Capture the Terraform plan output into a variable
plan_output=$(cat "$output_file")

if ${{ steps.evaluate-plan-exit-code.outputs.no_changes != 'true' }}; then
  # Extract the essential part of the output
  essential_output=$(extract_essential_output "$output_file")

  # Comment on PR
  if [[ -z $essential_output ]]; then
    comment_on_pr "Not able to extract Terraform essential output. Please check the plan output file."
  else
    comment_body=$(printf "## Terraform Plan Essential Output\n\`\`\`\n%s\n\`\`\`\n" "$essential_output")
    comment_on_pr "$comment_body"
  fi
else
  comment_on_pr "No Rover Plan changes detected. Pull Request safe to merge."
fi