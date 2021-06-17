# Push vs Pull Integration models

## Conceptual

| Concerns\Integration Model     | Push Model     | Pull Model     |
| --------------- |:-----------:|:-----------------:|
|1. Governance - How certificate policy is enforced ? | Certificate policy **can be** enforced in a proactive or manual manner | Certificate policy **must be** enforced in a proactive manner. |
|2. Governance - Visibility | Venafi's TPP | Venafi's TPP |
|3. Governance - Reporting | Venafi's TPP | Venafi's TPP |
|4. Governance - Notifications/Alerting | Venafi's TPP | Venafi's TPP **(and/or)** IaC Platform |
|5. Governance - Management | Venafi's TPP | Venafi's TPP **(and/or)** IaC Platform |
|6. Increasing footprint of certificate endpoints (Cloud/DevOps/NetOps) | Not Recommended | Recommended |
|7. How to integrate with change management process (SNOW) ? | Venafi's TPP | Venafi's TPP **(and/or)** IaC Platform |
|8. Who manages certificate lifecycle process ? | Venafi's TPP | Venafi's TPP **(and)** IaC Platform |
|9. Synchronous Bootstrapping/Initiation of Infrastructure/Application - Immutable infrastructure/application (Dynamic environment) | Not Recommended | Recommended |
|10. Mutable infrastructure/Immutable applications | Recommended | Recommended |
|11. Mutable infrastructure/Mutable applications (Static environment) | Recommended | Not Recommended |
|12. State management | Venafi's TPP | IaC platforms |
|13. Which model provides ease of Integratation with exiting CI/CD pipelines/workflows ? | Medium | Easy |
|14. Certificate Ownership (InfoSec/Security Engineering team) | Recommended | Not Recommended | 
|15. Certificate Ownership (Platforms) | Recommended | Recommended |
|16. Certificate Ownership (Development & Deployment Team) | Recommended (only for smaller/manual environments) | Recommended | 

<br>

## Technical 

| Concerns\Integration Model     | Push Model     | Pull Model     |
| --------------- |:-----------:|:-----------------:|
|1. Request/Renew cerificate | Venafi's TPP | IaC platform |
|2. Request/Renew + Install certificate | Venafi's TPP | IaC platforms |
|3. Decommission certificate | Venafi's TPP | IaC platforms **(and)** Venafi's TPP |
|4. Private/Public key generation | Venafi's TPP | IaC platforms |
|5. Organization in TPP | Folders/Device/Application/Certificate/Custom Fields | Folders/Certificate/Custom Fields |
|6. Validation/Monitoring | Venafi's TPP | IaC platform **(and/or)** Venafi's TPP (certificate based) |
|7. Notifications | Venafi's TPP | IaC platform **(and/or)** Venafi's TPP |
|8. Private Key Location | Venafi's TPP | IaC platforms |
|9. Automated Renewals | Venafi's TPP | IaC platforms |

<br>


