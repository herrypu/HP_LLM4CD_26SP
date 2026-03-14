def priority_encoder_golden(d):
    # Initialize outputs
    q = 0
    valid = 0
    
    # Determine the highest priority bit set
    if d & 0b1000:  # Check if d[3] is set
        q = 3
        valid = 1
    elif d & 0b0100:  # Check if d[2] is set
        q = 2
        valid = 1
    elif d & 0b0010:  # Check if d[1] is set
        q = 1
        valid = 1
    elif d & 0b0001:  # Check if d[0] is set
        q = 0
        valid = 1
    else:
        q = 0
        valid = 0

    return {'q': q, 'valid': valid}

# Test cases
test_patterns = [
    0b0000, 0b0001, 0b0010, 0b0011, 0b0100, 0b0101, 0b0110, 0b0111,
    0b1000, 0b1001, 0b1010, 0b1011, 0b1100, 0b1101, 0b1110, 0b1111,
    0b1011, 0b0110, 0b1001, 0b1101, 0b0011, 0b0101, 0b1110, 0b0111, 0b1010
]

for pattern in test_patterns:
    result = priority_encoder_golden(pattern)
    print(f"Input: {bin(pattern)[2:].zfill(4)}, Output: q={result['q']}, valid={result['valid']}")