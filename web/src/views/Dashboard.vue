<template>
    <div class="dashboard-widget">
        <div style="display: flex;flex-direction: row;">
            <div style="display: flex;justify-content: center;flex-direction: column;">
                <img style="height: 60px; width: 60px" src="../assets/eth.png" />
            </div>
            <div>
                <h2 style="font-size: 36px;">ETH</h2>
                <p style="font-size: 26px;">{{ balance }}</p>
            </div>
        </div>
    </div>
</template>

<script>
import { mapGetters } from 'vuex';

export default {
    computed: mapGetters(['wallet', 'balance']),
}
</script>

<style>

</style>
