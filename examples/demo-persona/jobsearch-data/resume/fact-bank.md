# Resume Fact Bank (DEMO PERSONA: Alex Rivera, fictional)

Every claim in a tailored resume must trace to an entry here.

## Contact

- Name: Alex Rivera
- Email: alex.rivera@example.com
- Phone: (555) 010-0142
- Location line: Boulder, CO · Remote

## Headline facts

- Years of experience: 12 (stated as "12 years")
- 5 years building event-driven systems on AWS

## Bluebird Freight — Senior Software Engineer, Platform

Remote · March 2021 – Present

- **Shipment event pipeline:** built an event-driven pipeline (Python, AWS Lambda, SQS) ingesting carrier tracking events, about **4 million events per day**, with idempotent processing and a dead-letter queue for replay.
- **LLM ticket triage:** built a support-ticket triage service that calls **Claude** with **tool calls** into the order-lookup API; created an **evaluation set of 300 labeled tickets** and gated prompt changes on it in CI. Cut median time to first response from **4 hours to 40 minutes**.
- **API platform:** designed the public shipment-status **REST API** (versioned, rate-limited, OpenAPI docs) used by about **200 shipper integrations**.
- **Reliability:** joined the on-call rotation; wrote runbooks; led two incident reviews.
- **Mentoring:** mentored 3 engineers; ran the team's design-review meeting.

## Cedar & Pine Health — Software Engineer II, then Senior Software Engineer

Remote · June 2016 – February 2021

- **Lab results interface:** built an **HL7 v2** interface that imported lab results from 12 partner labs into the patient record (Django, PostgreSQL).
- **Query performance:** tuned **PostgreSQL** queries and indexes for the appointments API, cutting p95 latency from **1.2 s to 180 ms**.
- **Scheduling API:** designed the patient appointment-scheduling API used by the web and mobile apps.

## Kettle Labs — Software Engineer

Denver, CO · July 2013 – May 2016

- Built Node.js services and React front ends for a small e-commerce analytics startup.

## Education

- University of Colorado Boulder: B.S. Computer Science

## Skills (only list what's evidenced above)

- **Languages:** Python, TypeScript / JavaScript, SQL
- **Data:** PostgreSQL, Redis (caching), SQS
- **AWS:** Lambda, ECS, SQS, S3, CloudWatch
- **AI:** Claude API, tool calling, evaluation sets in CI
- **Healthcare:** HL7 v2

## Not yet evidenced (do not claim without confirmation)

- Kubernetes
- Go
- RAG / vector search
- Fine-tuning or model training
