---
layout: page
title: Papers
permalink: /papers/
inheader: true
---

<img class="bigmug" alt="science!" src="/images/science.jpeg"/>

&nbsp;

# In Journals

{% bibliography --query @article %}

# In Conferences

{% bibliography --query @conference %}

# In Workshops

{% bibliography --query @inproceedings %}

# Tech Reports

{% bibliography --query @techreport %}

# Other

{% bibliography --query @phdthesis @misc %}

