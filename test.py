#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
FastAPI                                             May 27, 2024

source: test.py
author: @misael-diaz

Synopsis:
basic text completion example, borrowed from ref[0].

Copyright (c) 2024 Misael Díaz-Maldonado
This file is released under the GNU General Public License as published
by the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

References:
[0] https://github.com/bentoml/OpenLLM/blob/fd527352b2a610489cd843e0495cd64cc198f118/examples/openai_completion_client.py
"""


import openai

client = openai.OpenAI(base_url="http://localhost:3000/v1", api_key="na")

models = client.models.list()
model = models.data[0].id

prompt="Write a tagline for an ice cream shop."
completions = client.completions.create(prompt=prompt,
                                        model=model,
                                        max_tokens=64,
                                        stream=False)

print(completions)
