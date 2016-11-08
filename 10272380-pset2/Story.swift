//
//  Story.swift
//  Madlibs
//
//  Created by Julian Jansen on 13-04-16 for Swift 2.
//  Updated by Julian Jansen on 06-11-16 for Swift 3.
//
//  Based on: CS 193A, Marty Stepp
//
//  This class represents a Mad Libs story that comes from a text file.
//  You can construct it and pass an input stream to read the story text.
//  After constructing it, you can ask it for each placeholder by calling
//   getNextPlaceholder, then filling in that placeholder by calling fillInPlaceholder.
//  To see how many placeholders are left, use the methods
//   getPlaceholderRemainingCount and isFilledIn.
//  You can get the story's text by calling its toString method.

import Foundation

class Story {
    private var text: String                    // Text of the story.
    private var placeholders: Array<String>     // List of placeholders to fill in.
    private var filledIn: Int                   // Numbers of placeholders that have been filled in.
    private var htmlMode: Bool                  // Set to true to surround placeholders with <b></b> tags.
        
    /// Constructs a new Story reading its text from the given input stream.
    init(stream: String) {
        text = ""
        placeholders = Array<String>()
        filledIn = 0
        htmlMode = false
        read(stream: stream)
    }
    
    /// Returns story text.
    func toString() -> String {
        return text
    }
    
    /// Resets the story back to an empty initial state.
    func clear() {
        text = ""
        placeholders = Array<String>()
        filledIn = 0
    }
    
    /// Returns true if all placeholders have been filled in.
    func isFilledIn() -> Bool {
        return filledIn >= placeholders.count
    }
    
    /// Replaces the next unfilled placeholder with the given word.
    func fillInPlaceholder(word: String) {
        if (!isFilledIn()) {
            text = text.replacingOccurrences(of: "<\(filledIn)>", with: word)
            filledIn += 1
        }
    }
    
    /// Returns the next placeholder such as "adjective",
    /// or empty string if story is completely filled in already.
    func getNextPlaceholder() -> String {
        if (isFilledIn()) {
            return ""
        } else {
            return placeholders[filledIn]
        }
    }
    
    /// Returns total number of placeholders in the story.
    func getPlaceholderCount() -> Int {
        return placeholders.count;
    }
    
    /// Returns how many placeholders still need to be filled in.
    func getPlaceholderRemainingCount() -> Int {
        return placeholders.count - filledIn;
    }
    
    //// Reads initial story text from the given input stream.
    func read(stream: String) {
        
        let words = stream.characters.split{ $0 == " " || $0 == "\r\n" }.map(String.init)
        
        for word in words {
            if (word.hasPrefix("<") && word.hasSuffix(">")) {
                // A placeholder; replace with e.g. "<0>" so I can find/replace it easily later
                // (make them bold so that they stand out!).
                if (htmlMode) {
                    text += " <b><\(placeholders.count)></b>"
                } else {
                    text += " <\(placeholders.count)>"
                }
            
                // "<plural-noun>" becomes "plural noun".
                let range = word.index(after: word.startIndex)..<word.index(before: word.endIndex)
                let placeholder: String = word.substring(with: range).replacingOccurrences(of: "-", with: " ")
                placeholders.append(placeholder)
            } else {
                // A regular word; just concatenate.
                if (text.characters.count != 0) {
                    text += " ";
                }
                text += word;
            }
        }
    }
}