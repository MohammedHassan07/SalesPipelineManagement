import { LightningElement } from 'lwc';

import getMetrics from '@salesforce/apex/SalesPipelineMetricsService.getMetrics';

export default class SalesPipelineDashboard extends LightningElement {

    metrics;
    error;
    isLoading = true;

    connectedCallback() {
        this.loadMetrics();
    }

    get hasData() {
        return this.metrics !== undefined && !this.error;
    }

    get errorMessage() {
        return this.error?.body?.message || 'Unable to load sales pipeline metrics.';
    }

    async loadMetrics() {
        this.isLoading = true;
        this.error = undefined;

        try {
            this.metrics = await getMetrics();
        } catch (err) {
            this.error = err;
            this.metrics = undefined;

            console.error('Error loading sales pipeline metrics:', err);
        } finally {
            this.isLoading = false;
        }
    }

    handleRefresh() {
        this.loadMetrics();
    }
}