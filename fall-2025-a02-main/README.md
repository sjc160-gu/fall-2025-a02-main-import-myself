# Assignment: Data Science using Shell

**You should thoroughly read through the entire assignment before beginning your work!**

## Learning Objectives

By completing this assignment, you will:
1. Master fundamental bash text processing commands
2. Understand Unix philosophy of composing simple tools
3. Practice reproducible data analysis workflows
4. Develop debugging skills in shell environments
5. Learn to read documentation and adapt examples

## Development Environment Options

You can complete this assignment using one of the following environments:

1. **GitHub Codespaces** (recommended for consistency)
   - Clone the repository and launch Codespaces as in previous labs
   - All required tools are pre-installed

2. **Local Development**:
   - **Option A**: VS Code on your local laptop
     - Install VS Code and Git
     - Clone the repository locally
     - Open integrated terminal in VS Code
   - **Option B**: VS Code with Remote-SSH to Amazon EC2
     - Set up an EC2 instance with Ubuntu
     - Install VS Code Remote-SSH extension
     - Connect to your EC2 instance

## Allowed Tools and Commands

### Core Commands (allowed)
**Text Processing:**
- [`cat`](https://www.gnu.org/software/coreutils/manual/html_node/cat-invocation.html) - concatenate and display files
- [`head`](https://www.gnu.org/software/coreutils/manual/html_node/head-invocation.html) / [`tail`](https://www.gnu.org/software/coreutils/manual/html_node/tail-invocation.html) - display first/last lines
- [`cut`](https://www.gnu.org/software/coreutils/manual/html_node/cut-invocation.html) - extract columns
- [`grep`](https://www.gnu.org/software/grep/manual/grep.html) - search text patterns
- [`sed`](https://www.gnu.org/software/sed/manual/sed.html) - stream editor
- [`awk`](https://www.gnu.org/software/gawk/manual/gawk.html) - pattern scanning and processing

**Sorting and Counting:**
- [`sort`](https://www.gnu.org/software/coreutils/manual/html_node/sort-invocation.html) - sort lines
- [`uniq`](https://www.gnu.org/software/coreutils/manual/html_node/uniq-invocation.html) - report or omit repeated lines
- [`wc`](https://www.gnu.org/software/coreutils/manual/html_node/wc-invocation.html) - word, line, character count

**Math Operations:**
- [`bc`](https://www.gnu.org/software/bc/manual/html_mono/bc.html) - arbitrary precision calculator
- [`dc`](https://www.gnu.org/software/bc/manual/dc-1.05/html_mono/dc.html) - desk calculator
- Arithmetic expansion: `$((expression))`

**File Operations:**
- `echo`, `printf` - display text
- `tee` - read from stdin and write to stdout and files
- `>`, `>>`, `|` - redirection and pipes

### Not Allowed
- Python, R, or any programming language interpreters
- csvkit, jq, or specialized data tools
- Installing new packages via apt, brew, etc.
- Any tools not available in a standard bash environment

## AI Usage Policy

- **Encouraged**: Use AI tools to learn bash syntax and understand commands
- **Required disclosure**: Comment your code with `# AI-assisted:` when using AI for inspiration
- **Not allowed**: Direct copy-paste without understanding
- **Learning focus**: You must be able to explain every line of your code during evaluation

## Assignment Parts (Total: 100 points)

### Part 1: Data Exploration (10 points)

1. After cloning this repository, set up your chosen development environment.

2. Examine the data file `NCBirths2004.csv` using BASH commands. This dataset contains birth records from North Carolina in 2004 (historical data for educational purposes).

3. Extract the column names from the data file and save them to a file called `headers.txt`

### Part 2: Reproducible Analysis (50 points)

4. Create a reproducible BASH script called `data-script.bash`. Start by experimenting in the console, then save your working commands to the script file. **Include clear comments explaining each section!**

5. **Group-by Analysis: Median Weight by Smoking Status**
   
   Calculate the **median** `Weight` of babies for mothers who smoke vs. don't smoke:
   
   a. Filter the dataset to rows where `Smoker` is `Yes`
   b. Extract only the `Weight` column (exclude the header)
   c. Calculate the median of these weights
   d. Save the result to `smoker-yes-med.txt` (number only, no text)
   e. Repeat for `Smoker` = `No`, save to `smoker-no-med.txt`
   f. Display both results with clear labels
   g. Add a comment with a NON-TECHNICAL summary of the relationship

   **Note**: Median requires sorting values and finding the middle element. Handle both odd and even counts of data points.

6. **Group-by Analysis: Average Weight by Alcohol Use**
   
   Calculate the **average** `Weight` for `Alcohol` = `Yes` vs `No`:
   - Save results to `alcohol-yes-avg.txt` and `alcohol-no-avg.txt`
   - Add these commands to your `data-script.bash`
   - Display results with clear labels

### Part 3: Advanced Statistics (20 points)

7. **Standard Deviation Calculation**
   
   Calculate the standard deviation for `Weight` where `Alcohol` = `Yes`:
   - Formula: `sqrt(sum((x - mean)²) / n)`
   - Save result to `stddev-alcohol-yes.txt`
   - Use `bc -l` for floating-point math
   - You are encouraged to use AI assistance for this complex calculation
   - Mark with `# AI-assisted:` if you use AI

### Part 4: Testing and Documentation (20 points)

8. **Run Complete Script**
   
   Execute: `bash data-script.bash > bash-stdout.txt`
   
   This saves all output for evaluation. Ensure your script includes:
   - Clear comments for each section
   - Print statements with labels for results
   - Error handling for missing files

9. **Version Control**
   
   Commit your files with meaningful messages throughout your work. Here's a suggested commit strategy:
   - First commit: Add headers.txt
   - Second commit: Add median calculations
   - Third commit: Add average calculations
   - Fourth commit: Add standard deviation
   - Final commit: Add documentation files
   
   Note: This is just a suggestion - you may organize your commits differently as long as they are meaningful and show your progress.

10. **Bash History**
    
    Save your command history: `history > bash-history.txt`
    
    This helps instructors understand your problem-solving process.

## Submitting the Assignment

Required files for submission:
- `README.md` (this file)
- `NCBirths2004.csv` (provided)
- `headers.txt`
- `smoker-yes-med.txt`
- `smoker-no-med.txt`
- `data-script.bash`
- `bash-stdout.txt`
- `alcohol-yes-avg.txt`
- `alcohol-no-avg.txt`
- `stddev-alcohol-yes.txt`
- `bash-history.txt`

Submit a final commit with message: `final-submission`

**Do not modify your repository after the final-submission commit!**

## Helpful Hints

- **Testing**: Test your commands on small subsets first: `head -20 NCBirths2004.csv`
- **Median**: After sorting, use line counting and arithmetic to find middle value
- **Average**: Sum values with awk, divide by count
- **Debugging**: Use `set -x` in your script to see each command as it runs
- **Floating point**: Remember bash only does integer math; use `bc` for decimals

## Expected Output Format

Your output files should contain ONLY the numerical result:
- `smoker-yes-med.txt`: Single number (e.g., `3459.5`)
- `alcohol-yes-avg.txt`: Single number with decimals
- `stddev-alcohol-yes.txt`: Single number with decimals

## Common Issues and Solutions

- **"Command not found"**: Check spelling and ensure using allowed commands
- **Empty output files**: Check your filters and column selections
- **Wrong calculations**: Verify you're excluding headers from calculations
- **Median errors**: Remember to handle both odd/even number of values

## Grading Rubric

See [RUBRIC.md](RUBRIC.md) for detailed grading criteria.

## Additional Resources

- [HINTS.md](HINTS.md) - Additional tips without giving away solutions
- `sample_outputs/` - Directory with example output formats (values will differ)