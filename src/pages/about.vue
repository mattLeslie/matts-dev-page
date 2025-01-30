<template>

  <v-container class="fill-height align-start">
    <v-responsive class="mx-auto" max-width="900">
      <SectionHeader title="About"></SectionHeader>
      <div>
        <v-card-text v-for="paragraph in copyText">

          {{ paragraph }}

        </v-card-text>
      </div>

      <hr class="my-4" style="height:4px;border:none;color:white;background-color:white;">

      <v-container class="py-4" style="overflow-y: scroll !important;">
        <v-row justify="center">
          <v-col cols="12">

            <!-- Work History Section -->
            <v-card class="mb-8" elevation="3">
              <v-card-title class="text-h5 font-weight-bold">Work Experience</v-card-title>
              <v-divider></v-divider>
              <v-expansion-panels>
                <v-expansion-panel v-for="(job, index) in workHistory" :key="index">
                  <v-expansion-panel-title>
                    <div class="d-flex align-start ga-6">
                      <img :src="job.logo_img" width="60" height="60"></img>
                      <div>
                        <v-list-item-title class="text-h6">{{ job.title }}</v-list-item-title>
                        <v-list-item-subtitle class="text-subtitle-1 my-1">
                          {{ job.company }} • {{ job.years }}
                        </v-list-item-subtitle>
                        <v-list-item-subtitle class="text-subtitle-1 my-1">
                          {{ job.location }}
                        </v-list-item-subtitle>
                      </div>
                    </div>
                  </v-expansion-panel-title>
                  <v-expansion-panel-text>
                    <div class="my-4" v-for="line in job.lines"> • {{ line }}</div>
                  </v-expansion-panel-text>

                </v-expansion-panel>
              </v-expansion-panels>

            </v-card>

            <!-- Education Section -->
            <v-card elevation="3">
              <v-card-title class="text-h5 font-weight-bold">Education</v-card-title>
              <v-divider></v-divider>
              <v-list density="compact">
                <v-list-item v-for="(school, index) in education" :key="index">
                  <div class="d-flex align-start ga-6">
                    <img :src="school.logo_img" width="60" height="60"></img>
                    <div>
                      <v-list-item-title class="text-h6">{{ school.degree }}</v-list-item-title>
                      <v-list-item-subtitle class="text-subtitle-1">{{ school.institution }} • {{ school.years
                        }}</v-list-item-subtitle>
                      <v-list-item-subtitle class="text-body-2">
                        {{ school.location }}
                      </v-list-item-subtitle>
                    </div>
                  </div>
                </v-list-item>
              </v-list>
            </v-card>
          </v-col>
        </v-row>
      </v-container>

    </v-responsive>
  </v-container>
</template>


<script lang="ts" setup>

import usgs from '@/assets/usgs.jpeg'
import pearson from '@/assets/pearson.jpeg'
import siemens from '@/assets/siemens.jpeg'
import usc from '@/assets/usc.jpeg'

const copyText = [
  'I’m a full-stack software engineer building web applications for hydrology and climate science, currently supporting the USGS Web Informatics Team. My work revolves around creating tools that make environmental data more accessible, insightful, and actionable, helping scientists, policymakers, and the public better understand water and climate systems.',
  'I’m passionate about climate tech, renewable energy, and mapping, and I love exploring how technology can be leveraged for sustainability and conservation. When I’m not writing code, you’ll probably find me trail running, foraging for morel mushrooms, or geeking out over topographic maps.',
  'If any of that resonates with you—or if you just want to chat about cool projects—reach out! I’d love to connect.',
]

const workHistory = ref([
  {
    title: "Full Stack Software Engineer",
    company: "USGS Web Informatics Team",
    logo_img: usgs,
    years: "2024 - Present",
    location: "San Francisco, CA",
    lines: [
      'Cooperated with hydrologists to build a real-time flood visualization and warning dashboard with Vue3/Vuetify; added comprehensive test suite with Jest and Cypress.',
      'Built cost-effective microservices with AWS Lambda/DynamoDB to scrape and process NOAA datastreams.',
      'Wrote scalable cloud templates to generate and distribute regional flooding forecasts via a public API; designed parallel data processing pipelines to reduce forecast generation times by 400%.',
      'Collaborated with FEMA and the Army Corps of Engineers to build the national Flood Frequency Database and API using LiteStar, SQLAlchemy, Alembic, and PostGIS.',
      'Collected requirements and worked closely with subject matter experts to design a unified ERD; created TDD framework with pytest to drive API development.',
    ]
  },
  {
    title: "Software Engineering Intern",
    company: "Pearson",
    logo_img: pearson,
    years: "2022",
    location: "Remote",
    lines: [
      'Implemented a scalable GraphQL API with Java/Spring to enable e-learning content sales and distribution.',
      'Wrote performant SQL queries to integrate back-end resolvers with PostgreSQL databases.',
      'Optimized GraphQL queries via batching to improve API efficiency and reduce network traffic by up to 20%.'
    ]
  },
  {
    title: "Software Engineering Intern",
    company: "Siemens",
    logo_img: siemens,
    years: "2021",
    location: "Remote",
    lines: [
      'Created internal tooling for real-time management of email support tickets across global time zones.',
      'Interfaced with PostgreSQL personnel database to automate ticket assignment and escalation policies, eliminating manual tasks and improving resolution times by up to 16 hours.',
      'Worked closely with non-technical stakeholders to gather requirements and integrate user feedback.'
    ]
  }
]);

const education = ref([
  {
    degree: "B.S. in Computer Science",
    institution: "University of Southern California",
    logo_img: usc,
    years: "2019 - 2023",
    location: "Los Angeles, CA",
    lines: [


    ]
  }
]);


</script>


<style scoped></style>