//
// FileIO.swift
//
// Created by Remy Skelton
// Created on 2025-03-09
// Version 1.0
// Copyright (c) 2025 Remy Skelton. All rights reserved.
//
// The FileIO program will read from the input.txt file with integers,  
// decimal and non-numerics on each line.  
// It will then try to convert each of the different data types  
// from a string to an integer.  
// If it is successful, it will add the integer to the sum and  
// display the sum of the integers on the line.  
// If it is not successful, it will display an error message.  
// If there are no integers on the line, it will display an error message.  
// It will then write the output to the output.txt file.  

// Import foundation library
import Foundation

// Welcome message
print("Welcome to the file input/output program!")

// Define the InputError enum to handle errors
enum InputError: Error {
    case invalidInput
}

// Do-catch block to catch any errors
do {

    // Initialize output
    var outputStr = ""

    // initialize sum
    var sum = 0

    // Initialize numValidInt
    var numValidInt = 0

    // Define the file paths
    let inputFile = "./Unit2-02-input.txt"
    let outputFile = "./Unit2-02-output.txt"

    // Open the input file for reading
    guard let input = FileHandle(forReadingAtPath: inputFile) else {
        // Throw an error if the input file cannot be read
        throw InputError.invalidInput
    }

    // Open the output file for writing
    guard let output = FileHandle(forWritingAtPath: outputFile) else {
        // Throw an error if the output file cannot be written to
        throw InputError.invalidInput
    }

    // Read the contents of the input file
    let inputData = input.readDataToEndOfFile()

    // Convert the data to a string
    guard let inputStr = String(data: inputData, encoding: .utf8) else {
        // Throw an error if the data cannot be converted to a string
        throw InputError.invalidInput
    }

    // Split the input string into lines
    let inputLines = inputStr.components(separatedBy: "\n")

    // Initialize number of lines
    var position = 0

    // While loop to go through each line
    while (position) < (inputLines.count) {

        // Reset sum
        sum = 0

        // Reset numValidInt
        numValidInt = 0

        // Get the line
        let line = (inputLines)[position]

        // Split the line into numbers
        let numbers = line.components(separatedBy: " ")

        // For loop to go through each of the numbers
        for numStr in numbers {

            // Convert the numbers from a string to an int
            if let numInt = Int(numStr) {

                // Add the number to the sum
                sum += numInt

                // Increment numValidInt
                numValidInt += 1

            } else {
                // Error message
                outputStr += "\(numStr) is not a valid integer. \n"
            }
        }

        // Check if there are no valid integers on the line
        if numValidInt == 0 {
            // Display error message in the output
            outputStr += "Error: no integers were found on this line. \n"

            // New line at end
            outputStr += "\n"
        } else {
            // Add the sum to the output
            outputStr += "The sum of the valid integers is \(sum). \n"

            // New line at end
            outputStr += "\n"
        }

        // Increment the position
        position += 1
    }

    // Write the sum to the output file
    output.write(outputStr.data(using: .utf8)!)

    // Display a message for successful writing
    print("Wrote to the file successful.")

    // Close the output file
    output.closeFile()

    // Close the input file
    input.closeFile()

// Catch errors and display an error message
} catch InputError.invalidInput {
    // Display an error message
    print("Unable to read from the input file.")
}
