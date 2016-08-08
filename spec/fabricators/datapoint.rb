Fabricator(:datapoint) do
  dataset
  ts      { rand(30).months.ago }
  value   { rand(100000) }
end
