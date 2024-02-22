import { LightningElement } from "lwc";
import getMovies from "@salesforce/apex/MovieCloudController.getMovies";
import BASE_IMAGE_URL from "@salesforce/label/c.tmdb_base_image_url";
import { ShowToastEvent } from "lightning/platformShowToastEvent";

export default class MovieCloud extends LightningElement {''
  currentPage = 1;
  totalPage = 0;
  totalResults = 0;
  movies = [];
  errorMessage = null;
  label = {
    BASE_IMAGE_URL
  };

  async connectedCallback() {
    await this.loadMovies();
  }

  async loadMovies() {
    try {
      const response = await getMovies({
        parameters: {
          "include_adult": false,
          "include_video": false,
          "language": "en-US",
          "page": this.currentPage,
          "sort_by": "vote_average.desc",
          "vote_count.gte": 300,
          'with_runtime.gte': 0,
          'with_runtime.lte': 400
        }
      });
      response.results = response.results.map(movie => {
        movie.poster_path = this.label.BASE_IMAGE_URL + movie.poster_path;
        movie.backdrop_path = this.label.BASE_IMAGE_URL + movie.backdrop_path;
        return movie;
      });
      this.movies = [...this.movies, ...response.results];
      this.totalPage = response.total_pages;
      this.totalResults = response.total_results;
    } catch (error) {
      this.handleError(error);
    }
  }

  handleError(error) {
    this.errorMessage = error.body.message || error.message || JSON.stringify(error);
    this.dispatchEvent(new ShowToastEvent({
      title: "Error",
      message: this.errorMessage,
      variant: "error"
    }));
  }
}