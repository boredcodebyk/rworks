// place files you want to import through the `$lib` alias in this folder.

const db = [
    {
        id: "948ce290-4167-43ff-ae8b-4ee043158fd2",
        name: "TidyTuesday Week 15",
        date: new Date(1744876586263),
        link: "shiny/tidytuesday/2025/15/"
    }
]

function init() {
    let item = document.createElement("p");
    if (db.length != 0) {

        for (const i in db) {
            const element = db[i];
            let link = document.createElement("a");
            link.innerHTML = `<a href="${element.link}">${element.name}</a>`;
            let date = moment(element.date).format("MMMM Do YYYY");
            item.append(`[${date}]`," | ", link);
        }
    } else {
        item.innerHTML = "Come back later";
    }

    document.querySelector("#list").append(item);
}


init();
