MatchingBracket = require '../lib/matching-bracket'

describe "MatchingBracket", ->

  it "Finds the matching bracket", ->
    @matchingBracket = new MatchingBracket()
    result = @matchingBracket.position('Test { 123: { "DEF" }{} } abc', 5)
    expect(result).toEqual(24)

  it "Finds the other matching bracket", ->
    @matchingBracket = new MatchingBracket()
    result = @matchingBracket.position('Test { 123: { "DEF" }{} } abc', 12)
    expect(result).toEqual(20)

  it "No matching bracket returns -1", ->
    @matchingBracket = new MatchingBracket()
    result = @matchingBracket.position('Test { 123: { "DEF" }{} abc', 5)
    expect(result).toEqual(-1)
