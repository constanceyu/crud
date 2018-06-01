/*
Week 09 Exercise
================


Part 2: Mongo CRUD
==================

Part 2a: Creating Data
----------------------

** Insert Op 1: Insert the following document into a collection named `books`.

{
    title: 'Zen and the Art of Motorcycle Maintenance',
    author: 'Pirsig, Robert M.',
    year: 1974,
    classification: {
        subject: [
            {heading:'Philosophy'},
            {heading:'Pirsig, Robert M.', source:'LCSH'},
            {heading:'Pirsig, Robert M., -- 1928-2017.', source:'LCSH'},
            {heading:'Fathers and sons -- United States.', source:'LCSH'},
            {heading:'Self.', source:'LCSH'},
            {heading:'Fathers and sons.', source:'LCSH'},
            {heading:'United States.', source:'LCSH'}
        ],
        genre: 'Fiction'
    }
}

*/

// Your code goes here
// I did this one for you
db.books.insert(
{
    title: 'Zen and the Art of Motorcycle Maintenance',
    author: 'Pirsig, Robert M.',
    year: 1974,
    classification: {
        subject: [
            {heading:'Philosophy'},
            {heading:'Pirsig, Robert M.', source:'LCSH'},
            {heading:'Pirsig, Robert M., -- 1928-2017.', source:'LCSH'},
            {heading:'Fathers and sons -- United States.', source:'LCSH'},
            {heading:'Self.', source:'LCSH'},
            {heading:'Fathers and sons.', source:'LCSH'},
            {heading:'United States.', source:'LCSH'}
        ],
        genre: 'Fiction'
    }
})

/*


** Insert Op 2: Insert the following documents into the `books` collection.

{
    _id: '0-553-34584-2',
    title: "The Mind's I",
    author: ['Dennet, Daniel', 'Hofstadter, Douglas'],
    year: 1981,
    classification: {
        subject: [
            {heading:'Consciousness', source:'Wikipedia'},
            {heading:'Intellect', source:'Wikipedia'},
            {heading:'Philosophy', source:'Wikipedia'},
            {heading:'Mind-body dichotomy', source:'Wikipedia'},
            {heading:'Cognitive psychology', source:'Wikipedia'},
            {heading:'Theology', source:'Wikipedia'},
            {heading:'Self (philosophy)', source:'Wikipedia'},
            {heading:'Soul (spirit)', source:'Wikipedia'},
            {heading:'Consciousness', source:'LCSH'},
            {heading:'Consciousness -- Literary collections', source:'LCSH'},
            {heading:'Intellect', source:'LCSH'},
            {heading:'Intellect -- Literary collections', source:'LCSH'},
            {heading:'Self (Philosophy)', source:'LCSH'},
            {heading:'Self (Philosophy) -- Literary collections', source:'LCSH'},
            {heading:'Soul', source:'LCSH'},
            {heading:'Soul -- Literary collections', source:'LCSH'}
        ],
        genre: 'Nonfiction'
    }
}

{
    _id: '0-688-12141-1',
    title: 'The Language Instinct',
    author: 'Pinker, Stephen',
    year: 1994,
    classification: {
        subject: [
            {heading:'Psycholinguistics', source:'Wikipedia'},
            {heading:'Evolutionary psychology', source:'Wikipedia'},
            {heading:'Evolutionary psychology of language', source:'Wikipedia'},
            {heading:'Linguistics', source:'Wikipedia'},
            {heading:'Biolinguistics.', source:'LCSH'},
            {heading:'Language and languages.', source:'LCSH'}
        ],
        genre: 'Nonfiction'
    }
}

{
    _id: '0-19-857519-X',
    title: 'The Selfish Gene',
    author: 'Dawkins, Richard',
    year: 1976,
    classification: {
        subject: [
            {heading:'Evolutionary Biology', source:'Wikipedia'},
            {heading:'Evolution (Biology) -- Popular works', source:'LCSH'},
            {heading:'Natural selection -- Popular works', source:'LCSH'},
            {heading:'Evolution (Biology)', source:'LCSH'},
            {heading:'Natural Selection', source:'LCSH'}
        ],
        genre: 'Nonfiction'
    }
}

{
    _id: '0-393-03891-2',
    title: 'Guns, Germs, and Steel',
    author: 'Diamond, Jared',
    year: 1997,
    classification: {
        subject: [
            {heading:'Geography', source:'Wikipedia'},
            {heading:'social evolution', source:'Wikipedia'},
            {heading:'ethnology', source:'Wikipedia'},
            {heading:'cultural diffusion', source:'Wikipedia'},
            {heading:'Social evolution.', source:'LCSH'},
            {heading:'Civilization -- History.', source:'LCSH'},
            {heading:'Ethnology.', source:'LCSH'},
            {heading:'Human beings -- Effect of environment on.', source:'LCSH'},
            {heading:'Culture diffusion.', source:'LCSH'},
            {heading:'Civilization.', source:'LCSH'},
        ],
        genre: 'Nonfiction'
    }
}

*/

// Your code goes here
// You should use four individual commands





/*
Part 2b: Retrieving Data
------------------------

** Find Op 1: Retrieve the record with the id "0-688-12141-1"

*/

// Your code goes here






/*

** Find Op 2: Perform the same search as Find Op 1, but display only the `title`
and `author` fields.

*/

// Your code goes here






/*

** Find Op 3: Perform the same search as Find Op 2, but omit the `_id` field.

*/

// Your code goes here






/*

** Find Op 4: Perform the same search as Find Op 1, but omit the `_id`, 
`author`, and `year` fields from the results display.

*/

// Your code goes here







/*

** Find Op 5: Find all the books with a publication year greater than or equal 
to 1980 and with the the word "The" in the title. Display only the `title` and 
`year` fields.

*/

// Your code goes here






/*

** Find Op 6: Find all the books with a publication date between 1980 and 1990,
inclusive. Display only the titles and years.

*/

// Your code goes here






/*

** Find Op 7: Find all the books that have "Biology" in a subject heading. 
Display only the title and subjects in the results. 

*/

// Your code goes here






/*

** Find Op 8: Find all books with a genre of fiction. Display the title, year, 
and genre fields.

*/

//Your code goes here






/*

** Find Op 9: Use the `$all` operator to find books that have both "Philosophy"
and "Psychology" in their subject headings. Display the title, year, and 
subjects.

*/

// Your code goes here






/*

** Find Op 10: Perform the same operation as Find op 9, but find all books that
have *either* term in their list of subjects. Use the `$in` operator.

*/
// Your code goes here






/*

Part 2c: Updating data
----------------------

** Update Op 1: Add "autobiography" to the "genre" field for "Zen and the Art 
of Motorcycle Maintenance". 

Don"t do this!!!
db.books.update(
    {title: "Zen and the Art of Motorcycle Maintenance"},
    {"classification.genre": ["fiction", "autobiography"]}
)

*/

// Your code goes here







/*

Part 2d: Deleting Data
----------------------

Copy the document for "Zen and the Art of Motorcycle Maintenance" to a 
temporary variable. Then set the temporary doc's _id to 0-688-00230-7 and
insert it back to the database.

*/
var doc = db.books.findOne({title: "Zen and the Art of Motorcycle Maintenance"})

var old_id = doc._id

doc._id = "0-688-00230-7"

db.books.insert(doc)

/*

** Remove Op 1: Now, remove the old document.

*/

// Your code goes here





/*

Part 3: Advanced Usage
======================

Part 3a: Element Match
----------------------

** Adv Op 1: Use $elemMatch to find books that have "philosophy" (case 
insensitive) in their subject headings, but only if the heading is from LCSH.

*/

// Your code goes here











/*

Part 3b: References
-------------------
Create a second collection of documents called `reviews`, which have references
back to the `books` collection.

*/

// I'll do this one for you
db.reviews.insert(
    {
        rating: 5,
        review: "Mind-blowing! This book initiated my interest in cognitive science",
        book: {$ref:"books", $id:"0-553-34584-2"}
    }
)

db.reviews.insert(
    {
        rating: 5,
        review: "This books makes me want to improve the quality of my work in everything I do",
        book: {$ref:"books", $id:"0-688-00230-7"}
    }
)

/*

** Adv Op 2: Now execute `db.reviews.find()` to see the `_id` values and copy 
the first one. The perform a two step lookup of the review and the book it 
references.

*/

// Your code goes here








/*

Part 3c: Aggregations
---------------------

** Adv Op 3: Get the count of books that have "philosophy" (case insensitive) 
in their subject headings"

*/

// Your code goes here







/*

** Adv Op 4: Use the `distinct()` function to get a list of distinct values for
the subject source.

*/

// Your code goes here






/*

** Adv Op 5: Use `$match`, `$sort`, and `$project` to sort the nonfiction books 
by publication year in descending order.

*/

// Your code goes here















/*

** Adv Op 6: Use `$group` and `$avg` to get the average publication year of all
Nonfiction books.

*/

// Your code goes here










