# Sales Pipeline & Deal Management System

A Salesforce Sales Cloud project for managing sales opportunities,
validating business rules, automating follow-up activities, and
monitoring pipeline performance through Lightning Web Components,
Apex, Flow, reports, and dashboards.

The project uses standard Salesforce objects to keep the data model
simple while demonstrating practical Salesforce development skills.

## Overview

The Sales Pipeline & Deal Management System helps sales teams monitor
open opportunities, analyze Closed-Won revenue, and automate follow-up
activities during the sales process.

The project demonstrates how Salesforce declarative automation and
programmatic development can work together in a single application.

## Features

### 1. Opportunity Management

Uses standard Salesforce Account and Opportunity objects.

Features include:

- Manage sales opportunities.
- Associate opportunities with customer accounts.
- Track opportunity stages, amounts, and close dates.
- Monitor open and closed opportunities.
- Track Closed-Won revenue.

### 2. Apex Trigger and Handler

An Opportunity trigger delegates business logic to a separate handler
class to keep the implementation organized and maintainable.

Implemented validations:

- Prevent opportunities from being saved with negative amounts.
- Require a positive amount for Closed-Won opportunities.
- Apply validation during Opportunity creation and updates.

Technologies:

- Apex
- Salesforce Triggers
- Trigger handler pattern
- `addError()`

### 3. Automated Follow-Up Tasks

A Record-Triggered Flow runs when an Opportunity enters the configured
Proposal stage.

The Flow creates a follow-up Task with the following details:

- Subject: Follow Up on Sales Proposal
- Related record: Opportunity
- Assigned owner: Opportunity owner
- Due date: Three days after the Flow execution date
- Status: Not Started
- Priority: High

This automation helps sales representatives remember to follow up
with potential customers.

The Proposal stage value is configured for the Salesforce org.

### 4. Apex Pipeline Metrics Service

The `SalesPipelineMetricsService` Apex class calculates sales pipeline
metrics using aggregate SOQL queries.

The service returns:

- Total value of open opportunities
- Total Closed-Won revenue
- Number of open opportunities
- Number of Closed-Won opportunities

The service uses aggregate queries to calculate totals rather than
retrieving every Opportunity record into Apex.

### 5. Lightning Web Component Dashboard

The `salesPipelineDashboard` Lightning Web Component displays sales
pipeline metrics in a dashboard interface.

Dashboard metrics:

- Open Pipeline Value
- Closed-Won Revenue
- Open Opportunities
- Closed-Won Opportunities

Features:

- Retrieves data from Apex.
- Displays key sales metrics.
- Provides a refresh action.
- Displays loading and error states.
- Uses responsive CSS layouts.

Technologies:

- Lightning Web Components
- JavaScript
- HTML
- CSS
- Apex
- `@AuraEnabled`
- Aggregate SOQL

### 6. Salesforce Reports and Native Dashboard

The project can also use standard Salesforce reports and dashboards
to analyze sales performance.

Planned report configurations include:

- Open Opportunities by Stage
- Closed Won Revenue Analysis
- Opportunities Closing This Month

These reports can support pipeline analysis and sales prioritization.

> Mark this section as completed only after the reports and native
> dashboard have been created and verified in Salesforce.

### 7. Apex Unit Testing

The project includes tests for the Opportunity trigger handler and
pipeline metrics service.

Implemented test scenarios include:

- Valid Opportunity insertion
- Rejection of negative Opportunity amounts
- Rejection of zero-amount Closed-Won opportunities
- Valid Closed-Won Opportunity creation
- Rejection of negative amounts during updates
- Bulk insertion of 200 Opportunities
- Calculation of open pipeline value
- Calculation of Closed-Won revenue
- Verification of Opportunity counts

The tests create their own data instead of depending on manually
created records in the Salesforce org.

## Technology Stack

| Technology | Purpose |
|---|---|
| Salesforce Sales Cloud | CRM platform |
| Apex | Server-side business logic |
| Apex Triggers | Opportunity validation |
| SOQL | Salesforce data queries |
| Salesforce Flow | Follow-up Task automation |
| Lightning Web Components | Custom dashboard interface |
| HTML | Dashboard structure |
| CSS | Dashboard styling |
| JavaScript | Client-side behavior |
| Salesforce CLI | Development and deployment |
| Visual Studio Code | Development environment |
| Git | Version control |

## Architecture

```text
Sales Representative
        |
        v
Salesforce Opportunity
        |
        +---------------------------+
        |                           |
        v                           v
Opportunity Trigger           Record-Triggered Flow
        |                           |
        v                           v
Trigger Handler              Follow-Up Task
        |
        v
Business Rule Validation


Lightning Web Component
        |
        v
SalesPipelineMetricsService
        |
        v
Aggregate SOQL Queries
        |
        v
Opportunity Records
        |
        v
Dashboard Metrics
```

## Salesforce Data Model

The project primarily uses standard Salesforce objects.

| Object | Purpose |
|---|---|
| Account | Stores customer account information |
| Opportunity | Stores sales opportunities |
| Task | Stores follow-up activities created by Flow |

No custom objects are required for the core implementation.

The project also uses standard Opportunity fields, including:

- `Name`
- `AccountId`
- `StageName`
- `Amount`
- `CloseDate`
- `OwnerId`
- `IsClosed`
- `IsWon`

The exact available stage values depend on the Salesforce org's
configuration.

## Learning Outcomes

This project provides practical experience with:

- Salesforce standard objects and fields
- Apex triggers and handler classes
- Apex unit testing
- Bulk-safe trigger design
- SOQL and aggregate queries
- Record-Triggered Flows
- Lightning Web Components
- Apex-to-LWC integration
- Salesforce CLI
- Salesforce metadata deployment
- Git and GitHub
- Salesforce security fundamentals

## Author

**Mohammed Hassan**


