def binary_to_bcd_converter_golden(binary_input):
    # Ensure the input is a 5-bit integer
    if not (0 <= binary_input < 32):
        raise ValueError("binary_input must be a 5-bit integer (0 to 31)")

    # Initialize BCD output
    bcd_output = 0

    # Convert binary to BCD
    tens = 0
    ones = binary_input

    while ones >= 10:
        ones -= 10
        tens += 1

    # Combine tens and ones into BCD format
    bcd_output = (tens << 4) | ones

    # Return the result as a dictionary
    return {'bcd_output': bcd_output}