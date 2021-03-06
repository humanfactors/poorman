expect_equal(
  mtcars %>% select(MilesPerGallon = mpg, NumberOfGears = gear),
  {
    res <- mtcars[, c("mpg", "gear")]
    colnames(res) <- c("MilesPerGallon", "NumberOfGears")
    res
  },
  info = "Test renaming columns when selecting"
)

expect_equal(
  mtcars %>% select(MilesPerGallon = 1, NumberOfGears = 10),
  {
    res <- mtcars[, c("mpg", "gear")]
    colnames(res) <- c("MilesPerGallon", "NumberOfGears")
    res
  },
  info = "Test renaming columns when selecting using integers"
)

expect_equal(
  mtcars %>% select(MilesPerGallon = "mpg", NumberOfGears = "gear"),
  {
    res <- mtcars[, c("mpg", "gear")]
    colnames(res) <- c("MilesPerGallon", "NumberOfGears")
    res
  },
  info = "Test renaming columns when selecting using characters"
)

expect_equal(
  mtcars %>% select(MilesPerGallon = 1, Horsepower = "hp", NumberOfGears = gear),
  {
    res <- mtcars[, c("mpg", "hp", "gear")]
    colnames(res) <- c("MilesPerGallon", "Horsepower", "NumberOfGears")
    res
  },
  info = "Test renaming columns when selecting using a mixture of integer, character and nse names"
)

expect_equal(
  mtcars %>% select(MilesPerGallon = -mpg) %>% colnames(),
  colnames(mtcars)[-1L],
  info = "Negative column selections do not affect renaming"
)

expect_equal(
  mtcars %>% select(Columns = -mpg:-gear) %>% colnames(),
  "carb",
  info = "Negative column selections do not affect renaming in multiple column selections"
)

expect_equal(
  mtcars %>% select(Col = mpg:disp) %>% colnames(),
  c("Col1", "Col2", "Col3"),
  info = "Renaming columns during multiple column selection"
)

expect_equal(
  mtcars %>% select(11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1),
  mtcars[, rev(colnames(mtcars))],
  info = "Test order of selection is preserved"
)

expect_equal(
  mtcars %>% select(1, 1, 1, 1),
  mtcars[, "mpg", drop = FALSE],
  info = "Test selecting the same column multiple times only returns it once"
)

expect_equal(
  mtcars %>% select(mpg:disp, Gears = gear),
  {
    res <- mtcars[, c("mpg", "cyl", "disp", "gear")]
    colnames(res)[4] <- "Gears"
    res
  },
  info = "Ensure columns are named correctly when not all columns are to be renamed"
)

res <- suppressMessages(mtcars %>% group_by(cyl) %>% select(MilesPerGallon = mpg))
expect_equal(
  colnames(res),
  c("cyl", "MilesPerGallon"),
  info = "Ensure columns are named correctly when renaming grouped data"
)
