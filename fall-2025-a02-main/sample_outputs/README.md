# Sample Output Formats

This directory contains examples of the expected output format for each file.

**IMPORTANT**: The values shown here are examples only. Your actual values will differ based on the correct calculations from the dataset.

## File Formats

### headers.txt
Should contain comma-separated column names from the first row:
```
ID,MothersAge,Tobacco,Alcohol,Gender,Weight,Gestation,Smoker
```

### smoker-yes-med.txt
Should contain a single number (median weight):
```
3287.5
```

### smoker-no-med.txt
Should contain a single number (median weight):
```
3459.0
```

### alcohol-yes-avg.txt
Should contain a single number with decimals (average weight):
```
3245.6789
```

### alcohol-no-avg.txt
Should contain a single number with decimals (average weight):
```
3382.1234
```

### stddev-alcohol-yes.txt
Should contain a single number with decimals (standard deviation):
```
567.8901
```

### bash-stdout.txt
Should show the execution output with clear labels:
```
Extracting headers...
Headers saved to headers.txt

Calculating median weight for smoking mothers...
Median weight for smokers: 3287.5
Median weight for non-smokers: 3459.0

Babies born to non-smoking mothers tend to have higher birth weights.

Calculating average weight by alcohol consumption...
Average weight (alcohol=yes): 3245.6789
Average weight (alcohol=no): 3382.1234

Calculating standard deviation for alcohol=yes...
Standard deviation: 567.8901

Script execution complete!
```

## Important Notes

1. **Numbers only**: Output files should contain ONLY the numerical result
2. **No extra whitespace**: Don't include leading/trailing spaces or blank lines
3. **Decimal precision**: Use at least 2 decimal places for averages and standard deviation
4. **File encoding**: Use standard UTF-8 encoding
5. **Line endings**: Unix-style (LF) not Windows-style (CRLF)