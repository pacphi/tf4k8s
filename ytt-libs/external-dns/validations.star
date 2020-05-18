load("@ytt:data", "data")
load("@ytt:assert", "assert")

data.values.provider or assert.fail("missing provider")
