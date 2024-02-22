
function categoryHandler () {
        document.querySelector('#sorting').submit();
    }

    function prodDetailHandler(event) {
        let beans = event.target.getAttribute('id');
        //alert(beans);

        let url = '/coffee/goListDetail?beansNum=' + beans;
        location.href = url;
    }
    function init() {
        document.querySelector('#category').addEventListener('change', categoryHandler);
        document.querySelector('#beansTable').addEventListener('click', prodDetailHandler);

    }
    window.addEventListener('load', init);
