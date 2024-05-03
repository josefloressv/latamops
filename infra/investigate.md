```bash
│ Error: Provider produced inconsistent final plan
│ 
│ When expanding the plan for module.ecs_frontend.aws_ecs_service.service to include new values learned so far during apply, provider
│ "registry.terraform.io/hashicorp/aws" produced an invalid new value for .capacity_provider_strategy: planned set element
│ cty.ObjectVal(map[string]cty.Value{"base":cty.NullVal(cty.Number), "capacity_provider":cty.StringVal(""), "weight":cty.NullVal(cty.Number)}) does
│ not correlate with any element in actual.
│ 
```