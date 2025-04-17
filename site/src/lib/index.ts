// place files you want to import through the `$lib` alias in this folder.

interface Link {
    id: string,
    name: string,
    date: Date,
    link: string
}

const db: Link[] = [
    {
        id: "948ce290-4167-43ff-ae8b-4ee043158fd2",
        name: "TidyTuesday Week 15",
        date: new Date(1744876586263),
        link: "code/tidytuesday/2025/15/index.html"
    }
]


export {db};