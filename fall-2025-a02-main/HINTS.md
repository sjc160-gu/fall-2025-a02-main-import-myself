# Hints for Data Science Using Shell Assignment

## General Tips

### Understanding Your Data
Before diving into calculations, explore your data:
```bash
# See the structure
head -5 NCBirths2004.csv

# Count total rows
wc -l NCBirths2004.csv

# Check column positions
head -1 NCBirths2004.csv | tr ',' '\n' | nl
```

### Working with CSV Files
CSV files use commas to separate values. Key commands:
- `cut -d',' -f<column_number>` - extract specific column
- `grep` - filter rows
- `tail -n +2` - skip header row

## Part-Specific Hints

### Extracting Headers
Think about what makes the first line special. How can you get just that line?

### Filtering Data
When filtering for "Yes" or "No" values, be careful about:
- Exact matching vs partial matching
- Case sensitivity
- Column positions

Example pattern (not the exact solution):
```bash
grep ",Yes" file.csv  # Might match wrong column!
```

### Calculating Median
The median is the middle value when data is sorted:
1. Sort your numbers
2. Count how many values you have
3. Find the middle position
4. Extract that value

For even number of values, median is average of two middle values.

Useful commands to research:
- `sort -n` for numeric sorting
- `wc -l` for counting lines
- `sed -n '<line_number>p'` for getting specific line

### Calculating Average
Average = Sum of all values / Count of values

Approach:
1. Extract the column
2. Remove header
3. Sum all values (hint: awk can sum)
4. Count values
5. Divide sum by count

Example awk pattern for summing:
```bash
awk '{sum += $1} END {print sum}'
```

### Calculating Standard Deviation
This is the most complex calculation. Break it down:
1. Calculate mean first
2. For each value, calculate (value - mean)²
3. Sum all squared differences
4. Divide by count
5. Take square root

You'll need:
- Variables to store intermediate results
- `bc -l` for floating-point math and sqrt()
- Multiple passes through the data

### Making Your Script Reproducible
Structure your script like this:
```bash
#!/bin/bash

# Check if input file exists
if [ ! -f "NCBirths2004.csv" ]; then
    echo "Error: NCBirths2004.csv not found"
    exit 1
fi

# Part 1: Extract headers
echo "Extracting headers..."
# Your code here

# Part 2: Calculate median for smokers
echo "Calculating median weight for smoking mothers..."
# Your code here

# Continue for each part...
```

## Common Pitfalls to Avoid

### 1. Including Headers in Calculations
Always skip the header row when doing math:
```bash
tail -n +2 file.csv  # Start from line 2
```

### 2. Integer vs Float Division
Bash only does integer math:
```bash
echo $((10 / 3))     # Returns 3 (integer)
echo "10 / 3" | bc -l # Returns 3.33333... (float)
```

### 3. Empty Results
If your output files are empty, check:
- Is your grep pattern correct?
- Are you using the right column number?
- Did you redirect output correctly?

### 4. Wrong Column Selection
The Weight column might not be where you think:
```bash
# First, identify column positions
head -1 NCBirths2004.csv | tr ',' '\n' | nl
```

### 5. Spaces in Output
Ensure output files contain ONLY numbers:
```bash
# Bad: includes spaces or newlines
echo " 3459.5 " > file.txt

# Good: just the number
echo "3459.5" > file.txt
```

## Debugging Techniques

### 1. Test with Small Data
Create a test file with just a few lines:
```bash
head -20 NCBirths2004.csv > test.csv
```

### 2. Print Intermediate Results
Don't pipe everything at once. Check each step:
```bash
# Instead of one long pipe:
grep "Yes" file | cut -d',' -f6 | sort -n | ...

# Debug step by step:
grep "Yes" file > step1.txt
cut -d',' -f6 step1.txt > step2.txt
# Check each file to ensure it's correct
```

### 3. Use set -x for Debugging
Add to your script to see each command:
```bash
set -x  # Enable debugging
# your commands here
set +x  # Disable debugging
```

## Advanced Tips

### Using Variables
Store intermediate results:
```bash
count=$(wc -l < filtered.txt)
middle=$((count / 2))
```

### Handling Odd/Even Counts
```bash
if [ $((count % 2)) -eq 1 ]; then
    # Odd number - single middle value
else
    # Even number - average of two middle values
fi
```

### Precise Math with bc
```bash
# Set scale for decimal places
echo "scale=4; 22/7" | bc

# Square root
echo "sqrt(25)" | bc -l

# Multiple operations
echo "scale=4; (5 + 3) / 2" | bc
```

## Getting Help

### Man Pages
Read documentation for any command:
```bash
man grep
man awk
man bc
```

### Testing Regular Expressions
```bash
echo "test,Yes,data" | grep ",Yes"
```

### Checking Your Work
You can manually verify with a few data points:
1. Open the CSV in a text editor
2. Find a few "Yes" entries
3. Check if your script captures them correctly

## Remember

- Start simple, build complexity gradually
- Test frequently
- Comment your code
- It's okay to use multiple commands
- Google and AI are learning tools - understand what you use!