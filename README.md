# tf-plan-pr-comment

## Overview
tf-plan-pr-comment is a GitHub Action that automatically extracts and annotates essential Terraform plan output within GitHub Pull Requests. This action aims to enhance code reviews by providing a concise summary of the Terraform plan, making it easier for reviewers to understand the impact of the changes. It also aids in compliance by ensuring that only reviewed and approved Terraform changes are applied.

## Example Output


## Features
Extracts essential parts of the Terraform plan output.
Annotates the extracted output for better readability.
Comments the annotated output directly on the GitHub Pull Request.
Supports conditional comments based on the Terraform plan's exit code.

## Prerequisites
GitHub Actions must be enabled on your GitHub repository.
A Terraform project that you want to run this action on.
A GitHub Pull Request in the repository where you want to use this action.

## Inputs
Name	Description	Default	Required
output_file	The path to the file containing the Terraform plan output.	None	Yes

## Usage
Add the following step to your GitHub Actions workflow YAML file:

yaml
```
- name: Comment Terraform Plan on PR
  uses: [Your_GitHub_Org]/tf-plan-pr-comment@v1
  with:
    output_file: 'path/to/your/output/file'
```

## Example Workflow
Here's an example workflow that demonstrates how to use tf-plan-pr-comment:

yaml
```
name: Terraform CI

on:
  pull_request:
    paths:
      - '**.tf'

jobs:
  terraform:
    runs-on: ubuntu-latest

    steps:
    - name: Checkout code
      uses: actions/checkout@v2

    - name: Terraform Plan
      run: terraform plan -no-color 2>&1 | tee ${{ github.workspace }}/plan_output.txt

    - name: Comment Terraform Plan on PR
      uses: [Your_GitHub_Org]/tf-plan-pr-comment@v1
      with:
        output_file: ${{ github.workspace }}/plan_output.txt
```

## Contributing
Please read CONTRIBUTING.md for details on our code of conduct, and the process for submitting pull requests.

## License
This project is licensed under the MIT License - see the LICENSE.md file for details.

Feel free to modify this template to better suit your project's specific needs. This should give your users a good starting point for understanding how to use your GitHub Action effectively.