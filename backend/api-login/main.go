package main

import (
	"github.com/gofiber/fiber/v2"
	"github.com/gofiber/fiber/v2/middleware/cors"
	"gorm.io/driver/postgres"
	"gorm.io/gorm"
)

type Foo struct {
	Id          uint   `json:"id"`
	Title       string `json:"title"`
	Description string `json:"description"`
	Comments    []Bar  `json:"comments" gorm:"-" default:"[]"`
}

type Bar struct {
	Id     uint   `json:"id"`
	PostID uint   `json:"post_id"`
	Text   string `json:"text"`
}

func main() {
	dsn := "host=localhost user=postgres port=5432 dbname=customers sslmode=disable password=admin"
	db, err := gorm.Open(postgres.Open(dsn), &gorm.Config{})

	if err != nil {
		panic(err)
	}

	db.AutoMigrate(Foo{})

	app := fiber.New()

	app.Use(cors.New())

	app.Get("/", func(c *fiber.Ctx) error {

		return c.JSON(fiber.Map{
			"hello": "world!",
		})
	})

	app.Post("/api/get", func(c *fiber.Ctx) error {
		var foo Foo

		if err := c.BodyParser(&foo); err != nil {
			return err
		}

		return c.JSON(fiber.Map{
			"id":          "Hello",
			"title":       "world!",
			"description": "HELLO WORLD!",
		})
	})

	app.Listen(":8000")
}
