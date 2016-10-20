module.exports =
class MatchingBracket
  position: (line, bracket_position) ->
    bracket = line[bracket_position]
    matching_bracket = @matchingBracket(bracket)
    pos = -1
    ignore = 0
    for char, index in line[bracket_position..]
      if char == bracket && index > 0
        ignore++
      if char == matching_bracket
        if ignore == 0
          pos = index + bracket_position
          break
        else
          ignore--
    return pos

  matchingBracket: (bracket) ->
    matching_brackets =
      '{' : '}'
      '[' : ']'
      '(' : ')'
    matching_bracket = matching_brackets[bracket]
    @error("bad bracket #{bracket}") if !matching_bracket
    return matching_bracket

  error: (msg) ->
    throw msg
