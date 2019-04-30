<template>
    <div>
        <router-link :to="to">
            <div class="sidebar-button" :class="{ active: active }">
                <div class="sidebar-accent" />
                <h4>{{ label }}</h4>
            </div>
        </router-link>
    </div>
</template>

<script>
export default {
    props: {
        label: String,
        active: Boolean,
        icon: String,
        to: String
    }
}
</script>

<style>
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
        background-color: #0082e4;
    }
    .sidebar-button:hover h4, .sidebar-button:hover i {
        color: #0082e4
    }
    .active h4, .active i {
        color: #0082e4;
    }
    .active .sidebar-accent {
        background-color: #0082e4;
    }
    h4 {
        font-family: -apple-system,BlinkMacSystemFont,Segoe UI,Roboto,Helvetica Neue,Arial,sans-serif;
        font-weight: 400;
        text-decoration: none !important;
        color: #3d5170;
        margin: auto 20px auto 10px;
        transition: all 0.2s ease-in-out;
    }
    .active {
        color: #0082e4;
    }
    i {
        margin-left: 20px;
    }
</style>
