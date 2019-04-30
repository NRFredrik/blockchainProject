<template>
    <div class="dashboard-widget full-width">
        <form enctype="multipart/form-data"> 
            <input @change="readFile" type="file" />
        </form>
        {{ filehash }}
    </div>
</template>

<script>
import FileUpload from 'vue-upload-component'
import { keccak256 } from 'web3-utils';

export default {
    components: {
        FileUpload
    },
    data: function() {
        return {
            filename: '',
            filehash: ''
        }
    },
    methods: {
        readFile(f) { 
            let self = this;
            this.filename = f.target.files[0].name
            var reader = new FileReader();
            reader.onload = function() {
                self.filehash = keccak256(this.result)
            }
            reader.readAsBinaryString(f.target.files[0]);
        }
    }
}
</script>

<style>

</style>
