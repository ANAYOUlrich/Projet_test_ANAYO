<form method="POST" action="/api/publication/store" enctype="multipart/form-data">


                                                {{ csrf_field() }}

                                                

                                                <div class="col-md-6">
                                                                <div class="form-group">
                                                                    <label class="form-label">titre<span
                                                                            class="text-danger"></span></label>
                                                                    <input type="text" class="form-control"
                                                                        value="{{ old('titre') ?? ($item->titre ?? '') }}"
                                                                        name="slogan" />
                                                                    @if ($errors->has('titre'))
                                                                        <span
                                                                            class="text-danger">{{ $errors->first('titre') }}</span>
                                                                    @endif
                                                                </div>
                                                            </div>

                                                            <div class="col-md-6">
                                                                <div class="form-group">
                                                                    <label class="form-label">Contenu<span
                                                                            class="text-danger"></span></label>
                                                                    <input type="text" class="form-control"
                                                                        value="{{ old('contenu') ?? '' }} "
                                                                        name="slogan" />
                                                                    @if ($errors->has('contenu'))
                                                                        <span
                                                                            class="text-danger">{{ $errors->first('contenu') }}</span>
                                                                    @endif
                                                                </div>
                                                            </div>

<button type="submit" class="btn btn-primary">
                                                                    Enregistrer
                                                                
                                                                </button>
                                                        </form>

