#!/usr/bin/awk -f
BEGIN {
  Rule = ARGV[1]
  Width = 238
  GridWidth = 2000
  split("111 110 101 100 011 010 001 000", Patterns)
  for (i = 1; i in Patterns; i++) PatternsI[Patterns[i]] = i - 1
  ruleBits(Rule, RuleBits)
  makeGrid(Grid)
  for (i = 0; i < 100000; i++) {
    printGrid(Grid)
    step(Grid, RuleBits)
    if (system("bash -c 'sleep 0.02'")) exit
  }
}
function step(grid,ruleBits,   i, nextGrid) {
  for (i = 1; i < GridWidth - 1; i++) nextGrid[i] = ruleBits[PatternsI[grid[i - 1] grid[i] grid[i + 1]]]
  for (i = 0; i < GridWidth; i++) grid[i] = 1 == nextGrid[i]
}
function makeGrid(grid,   half,i) {
  half = GridWidth / 2
  for (i = 0; i < GridWidth; i++) grid[i] = i == half
}
function printGrid(grid,   start,i) {
  start = (GridWidth - Width) / 2
  for (i = 0; i < Width; i++) printf grid[start + i] ? "█" : " "
  print
}
function ruleBits(rule, rBits,   i) {
  for (i = 7; i >= 0; i--) rule = (rule - (rBits[i] = rule % 2)) / 2
}