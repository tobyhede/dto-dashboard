Fabricator(:dataset) do
  organisation
  name { sequence(:name) { |i| "dataset-#{i}" } }
end
