<template>
    <div :class="{ active: active}" class="sidebar-button">
        <div class="sidebar-accent" />
        <v-icon>md-dashboard</v-icon>
        <h4> {{ label }}</h4>
    </div>
</template>

<script>
export default {
    props: {
        label: String,
        active: Boolean
    }
}
</script>

<style scoped>
    .sidebar-button {
        display: flex;
        height: 50px;
        cursor: pointer;
        border-bottom: 1px solid #e1e5eb;
    }
    .sidebar-accent {
        height: 100%;
        width: 3px;
        transition: all 0.2s ease-in-out;
    }
    .sidebar-button:hover .sidebar-accent {
        background-color: #007bff;
    }
    .sidebar-button:hover h4 {
        color: #007bff
    }
    .active h4{
        color: #007bff;
    }
    .active .sidebar-accent {
        background-color: #007bff;
    }
    h4 {
        font-family: -apple-system,BlinkMacSystemFont,Segoe UI,Roboto,Helvetica Neue,Arial,sans-serif;
        font-weight: 400;
        color: #3d5170;
        margin: auto 20px;
        transition: all 0.2s ease-in-out;
    }
    .active {
        color: #007bff;
    }
</style>
