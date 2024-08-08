// GET API REQUEST
async function get_visitors() {
    // call azure function to get vistor account from cosmo db
    //await post_visitor();
    try {
        let response = await fetch('https://ydsunfunction.azurewebsites.net/api/HttpTrigger?', {
            method: 'GET',
        });
        let data = await response.json()
        document.getElementById("visitors").innerHTML = data['Count'];
        console.log(data);
        return data;
    } catch (err) {
        console.error(err);
    }
}


get_visitors();